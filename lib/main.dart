// import 'dart:collection';
import 'dart:io';

import 'package:flight_log_analyzer/Widgets/action_bar.dart';
import 'package:flight_log_analyzer/Widgets/main_body.dart';
import 'package:flight_log_analyzer/models/data_model.dart';
import 'package:flutter/material.dart';

import 'file system/file_handler.dart';
import 'file system/parse_log_file.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // final List<Sensor> sensors = [];

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

    final String searchString = _paramsFilterControler.text;

    if (searchString.isEmpty) {
      res = dataModel.parameters;
    } else {
      if (searchString.startsWith('/')) {
        res = dataModel.parameters
            .where((param) =>
                param.name.toLowerCase().startsWith(searchString.substring(1)))
            .toList();
      } else {
        res = dataModel.parameters
            .where((param) => param.name.toLowerCase().contains(searchString))
            .toList();
      }
    }

    setState(() {
      _filteredParameters = res;
    });
  }

  void handleFileOpen() async {
    File? file = await openLogFile();

    if (file != null) {
      setState(() {
        parseLogFile(file, dataModel);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ActionBar(),
            MainBody(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //   child: TextField(
            //     controller: _paramsFilterControler,
            //     decoration: const InputDecoration(label: Text('Filter:')),
            //   ),
            // ),
            // Center(
            //   child: TextButton(
            //       onPressed: handleFileOpen,
            //       child: const Text('Open Log file')),
            // ),
            // Expanded(
            //   // flex: 2,
            //   child: ListView.builder(
            //     itemCount: _filteredParameters.length,
            //     itemBuilder: (ctx, index) => Row(
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(_filteredParameters[index].name),
            //         ),
            //         const Spacer(),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(_filteredParameters[index].value.toString()),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
