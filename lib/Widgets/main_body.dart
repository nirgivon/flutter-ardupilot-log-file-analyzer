import 'package:flight_log_analyzer/Widgets/Graph/graph_display_w.dart';
import 'package:flight_log_analyzer/Widgets/Parameters/parameters_list_w.dart';
import 'package:flight_log_analyzer/models/data_model.dart';
import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  const MainBody(this.dataModel, {super.key});
  final DataModel dataModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: 260,
            child: ParametersListW(dataModel),
          ),
          const SizedBox(
            width: 100,
          ),
          LineChartSample1(dataModel),
        ],
      ),
    );
  }
}
