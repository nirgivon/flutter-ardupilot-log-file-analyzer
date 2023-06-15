// import 'dart:collection';

import 'package:flight_log_analyzer/Widgets/action_bar.dart';
import 'package:flight_log_analyzer/Widgets/main_body.dart';
import 'package:flight_log_analyzer/models/data_model.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void handleFileOpen() async {
  //   File? file = await openLogFile();

  //   if (file != null) {
  //     setState(() {
  //       parseLogFile(file, dataModel);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            ActionBar(),
            MainBody(dataModel),
          ],
        ),
      ),
    );
  }
}
