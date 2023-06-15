import 'dart:io';

import 'package:flight_log_analyzer/file%20system/file_handler.dart';
import 'package:flight_log_analyzer/file%20system/parse_log_file.dart';
import 'package:flutter/material.dart';
import 'package:flight_log_analyzer/models/data_model.dart';

class ParametersListW extends StatefulWidget {
  const ParametersListW(this.dataModel, {super.key});

  final DataModel dataModel;

  @override
  _ParametersListWState createState() => _ParametersListWState();
}

class _ParametersListWState extends State<ParametersListW> {
  List<Parameter> _filteredParameters = [];

  final _paramsFilterControler = TextEditingController();

  @override
  void initState() {
    _paramsFilterControler.addListener(paramsFilterTextChanged);
    _filteredParameters = widget.dataModel.parameters;
    super.initState();
  }

  @override
  void dispose() {
    _paramsFilterControler.dispose();
    super.dispose();
  }

  void handleFileOpen() async {
    File? file = await openLogFile();

    if (file != null) {
      setState(() {
        parseLogFile(file, widget.dataModel);
      });
    }
  }

  void paramsFilterTextChanged() {
    // print(_paramsFilterControler.text);

    List<Parameter> res = [];

    final String searchString = _paramsFilterControler.text;

    if (searchString.isEmpty) {
      res = widget.dataModel.parameters;
    } else {
      if (searchString.startsWith('/')) {
        res = widget.dataModel.parameters
            .where((param) =>
                param.name.toLowerCase().startsWith(searchString.substring(1)))
            .toList();
      } else {
        res = widget.dataModel.parameters
            .where((param) => param.name.toLowerCase().contains(searchString))
            .toList();
      }
    }

    setState(() {
      _filteredParameters = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextButton(
              onPressed: handleFileOpen, child: const Text('Open Log file')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            controller: _paramsFilterControler,
            decoration: const InputDecoration(label: Text('Filter:')),
          ),
        ),
        Expanded(
          // flex: 2,
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
      ],
    );
  }
}
