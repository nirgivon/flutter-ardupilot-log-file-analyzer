import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flight_log_analyzer/helpers/helpers.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

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
        logger.d({lines[0]});
        logger.d({lines[0].trim()});
        final tokens = lines[0].trim().replaceAll(' ', '').split(',');
        for (final token in tokens) {
          logger.d({token});
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: TextButton(
              onPressed: openFileDialog, child: const Text('Click Me')),
        ),
      ),
    );
  }
}
