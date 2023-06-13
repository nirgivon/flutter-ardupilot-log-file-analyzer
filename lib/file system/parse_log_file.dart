import 'dart:io';

import 'package:flight_log_analyzer/helpers/helpers.dart';
import 'package:flight_log_analyzer/models/data_model.dart';

Future<void> parseLogFile(File file, DataModel dataModel) async {
  // if (kDebugMode) {}
  // print(file.path);

  var length = await file.length();
  logger.i(file.path);

  stopwatch.start();
  final lines = file.readAsLinesSync();
  final numberOfLines = lines.length;
  stopwatch.stop();

  logger.i(
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

        // sensors.add(sensor);
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
  // for (final sensor in sensors) {
  //   logger.d(sensor.parameterNames);
  // }
}
