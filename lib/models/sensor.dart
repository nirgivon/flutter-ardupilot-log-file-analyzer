class Sensor {
  final int id;
  final String name;
  String? units;

  List<String> parameterNames = [];

  // List<List<Parameter>> parameters = [[]];

  Sensor({required this.id, required this.name});

  // set units(String u) {
  //   units = u;
  // }
}
