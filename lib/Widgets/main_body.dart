import 'package:flight_log_analyzer/Widgets/Parameters/parameters_list_w.dart';
import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  const MainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          SizedBox(
            width: 260,
            child: ParametersListW(),
          ),
          const SizedBox(
            width: 100,
          ),
          const Text('main body'),
        ],
      ),
    );
  }
}
