import 'dart:io';

import 'package:flight_log_analyzer/helpers/helpers.dart';
import 'package:flight_log_analyzer/models/data_model.dart';
import 'package:flight_log_analyzer/models/data_set.dart';

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
    parseLineInfo(line, dataModel);
  }
  for (final line in lines) {
    parseLineData(line, dataModel);
  }

  // final tokens = line.trim().replaceAll(' ', '').split(',');

  // switch (tokens[0]) {
  //   case 'FMT':
  //     int? id = int.tryParse(tokens[1]);
  //     String name = tokens[3];

  //     if (id == null) {
  //       logger.e('Could not parse sensor id: ${tokens[1]}');
  //       break;
  //     }
  //     final Sensor sensor = Sensor(id: id, name: name);

  //     for (int i = 5; i < tokens.length; i++) {
  //       sensor.parameterNames.add(tokens[i]);
  //     }

  //     dataModel.sensors.add(sensor);
  //     // sensors.add(sensor);
  //     break;
  //   case 'PARM':
  //     String name = tokens[2];
  //     double? value = double.tryParse(tokens[3]);
  //     if (value == null) {
  //       logger.e('PARM: Could not parse parameter value: ${tokens[3]}');
  //       break;
  //     }

  //     dataModel.parameters.add(Parameter(name: name, value: value));
  //     break;

  //   case 'FMTU':
  //     int? id = int.tryParse(tokens[2]);
  //     if (id == null) {
  //       logger.e('FMTU: Could not parse parameter id: ${tokens[2]}');
  //       break;
  //     }

  //     for (var sensor in dataModel.sensors) {
  //       if (sensor.id == id) {
  //         sensor.FMTU = tokens[3];
  //         sensor.MULT = tokens[4];
  //       }
  //     }

  //     break;

  //   case 'UNIT':
  //     break;
  //   case 'MULT':
  //     break;
  //   case 'MSG':
  //     break;
  //   case 'MODE':
  //     break;
  //   case 'CAND':
  //     break;

  //   default:
  //     final String name = tokens[0];
  //     for (var sensor in dataModel.sensors) {
  //       if (sensor.name == name) {
  //         double time = double.parse(tokens[1]);
  //         int sensorIndex = 0;
  //         bool sensorHasMultipleDataSets = false;

  //         if (sensor.FMTU!.contains('#')) {
  //           sensorIndex = int.parse(tokens[2]);
  //           sensorHasMultipleDataSets = true;
  //         }

  //         DataSet dataSet;

  //         if (sensor.dataSet.length < sensorIndex + 1) {
  //           dataSet = DataSet();
  //           sensor.dataSet.add(dataSet);
  //         } else {
  //           dataSet = sensor.dataSet[sensorIndex];
  //         }

  //         dataSet.time.add(time);

  //         int startIndex = 2;
  //         if (sensorHasMultipleDataSets) {
  //           startIndex = 3;
  //         }

  //         for (int i = startIndex; i < tokens.length; i++) {
  //           double? val = double.tryParse(tokens[i]);

  //           if (val == null) {
  //             logger.e(
  //                 'Could not parse value: ${tokens[i]} for parameter: ${sensor.parameterNames[i - startIndex]}');
  //             continue;
  //           }

  //           dataSet.dataPoints[sensorIndex].add(val);
  //         }
  //       }
  //     }

  //     break;
  // }
  // }
  // for (final sensor in sensors) {
  //   logger.d(sensor.parameterNames);
  // }
}

void parseLineInfo(String line, DataModel dataModel) {
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

      dataModel.sensors.add(sensor);
      // sensors.add(sensor);
      break;
    case 'PARM':
      String name = tokens[2];
      double? value = double.tryParse(tokens[3]);
      if (value == null) {
        logger.e('PARM: Could not parse parameter value: ${tokens[3]}');
        break;
      }

      dataModel.parameters.add(Parameter(name: name, value: value));
      break;

    case 'FMTU':
      int? id = int.tryParse(tokens[2]);
      if (id == null) {
        logger.e('FMTU: Could not parse parameter id: ${tokens[2]}');
        break;
      }

      for (var sensor in dataModel.sensors) {
        if (sensor.id == id) {
          sensor.FMTU = tokens[3];
          sensor.MULT = tokens[4];
        }
      }

      break;

    case 'UNIT':
      break;
    case 'MULT':
      break;
    case 'MSG':
      break;
    case 'MODE':
      break;
    case 'CAND':
      break;

    default:
      break;
  }
}

void parseLineData(String line, DataModel dataModel) {
  final tokens = line.trim().replaceAll(' ', '').split(',');

  switch (tokens[0]) {
    case 'FMT':
      break;
    case 'PARM':
      break;
    case 'FMTU':
      break;
    case 'UNIT':
      break;
    case 'MULT':
      break;
    case 'MSG':
      break;
    case 'MODE':
      break;
    case 'CAND':
      break;

    default:
      final String name = tokens[0];
      for (var sensor in dataModel.sensors) {
        if (sensor.name == name) {
          double time = double.parse(tokens[1]);
          int sensorIndex = 0;
          bool sensorHasMultipleDataSets = false;

          if (sensor.FMTU!.contains('#')) {
            sensorIndex = int.parse(tokens[2]);
            sensorHasMultipleDataSets = true;
          }

          DataSet dataSet;

          if (sensor.dataSet.length < sensorIndex + 1) {
            dataSet = DataSet();
            sensor.dataSet.add(dataSet);
          } else {
            dataSet = sensor.dataSet[sensorIndex];
          }

          dataSet.time.add(time);

          int startIndex = 2;
          if (sensorHasMultipleDataSets) {
            startIndex = 3;
          }

          for (int i = startIndex; i < tokens.length; i++) {
            double? val = double.tryParse(tokens[i]);

            if (val == null) {
              logger.e(
                  'Could not parse value: ${tokens[i]} for parameter: ${sensor.parameterNames[i - startIndex]}');
              continue;
            }

            int j = i - startIndex;
            if (dataSet.dataPoints.length < j + 1) {
              dataSet.dataPoints.add([]);
            }

            dataSet.dataPoints[j].add(val);
          }
        }
      }

      break;
  }
}
