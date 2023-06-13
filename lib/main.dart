// import 'dart:collection';
import 'dart:io';

import 'package:flight_log_analyzer/models/data_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flight_log_analyzer/helpers/helpers.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Sensor> sensors = [];

  final DataModel dataModel = DataModel();
  final _paramsFilterControler = TextEditingController();

  List<Parameter> _filteredParameters = [];

  @override
  void initState() {
    _paramsFilterControler.addListener(paramsFilterTextChanged);
    _filteredParameters = dataModel.parameters;
    super.initState();
  }

  @override
  void dispose() {
    _paramsFilterControler.dispose();
    super.dispose();
  }

  void paramsFilterTextChanged() {
    // print(_paramsFilterControler.text);

    List<Parameter> res = [];
    if (_paramsFilterControler.text.isEmpty) {
      res = dataModel.parameters;
    } else {
      res = dataModel.parameters
          .where((param) =>
              param.name.toLowerCase().contains(_paramsFilterControler.text))
          .toList();
    }
    setState(() {
      _filteredParameters = res;
    });
  }

  void openFileDialog() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'log',
      ],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      if (kDebugMode) {
        // print(file.path);
        var length = await file.length();
        logger.d(file.path);
        stopwatch.start();
        final lines = file.readAsLinesSync();
        final numberOfLines = lines.length;
        stopwatch.stop();
        logger.d(
            'File size: $length bytes, number of lines: $numberOfLines, time: ${stopwatch.elapsed}');

        for (final line in lines) {
          final tokens = line.trim().replaceAll(' ', '').split(',');

          switch (tokens[0]) {
            case 'FMT':
              int? id = int.tryParse(tokens[1]);
              String name = tokens[3];

              if (id == null) {
                logger.e('Could not parse sensor id: ${tokens[1]}');
                break;
              }
              final Sensor sensor = Sensor(id: id, name: name);

              for (int i = 5; i < tokens.length; i++) {
                sensor.parameterNames.add(tokens[i]);
              }

              sensors.add(sensor);
              break;
            case 'PARM':
              String name = tokens[2];
              double? value = double.tryParse(tokens[3]);
              if (value == null) {
                logger.e('Could not parse parameter value: ${tokens[3]}');
                break;
              }

              dataModel.parameters.add(Parameter(name: name, value: value));
              break;
          }
        }
        for (final sensor in sensors) {
          logger.d(sensor.parameterNames);
        }
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: TextField(
                  controller: _paramsFilterControler,
                  decoration: const InputDecoration(label: Text('Filter:')),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemCount: _filteredParameters.length,
                itemBuilder: (ctx, index) => Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_filteredParameters[index].name),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(_filteredParameters[index].value.toString()),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Center(
                child: TextButton(
                    onPressed: openFileDialog, child: const Text('Click Me')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
