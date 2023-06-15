import 'package:flight_log_analyzer/models/data_set.dart';

class Sensor {
  final int id;
  final String name;
  String? FMTU;
  String? MULT;

  List<String> parameterNames = [];

  List<DataSet> dataSet = [];

  Sensor({required this.id, required this.name});

  // set units(String u) {
  //   units = u;
  // }
}
