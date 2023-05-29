import 'package:flight_log_analyzer/models/sensor.dart';
import 'package:flight_log_analyzer/models/parameter.dart';

export 'package:flight_log_analyzer/models/sensor.dart';
export 'package:flight_log_analyzer/models/parameter.dart';

class DataModel {
  List<Sensor> sensors = [];
  List<Parameter> parameters = [];
}
