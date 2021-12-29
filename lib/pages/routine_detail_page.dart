import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';
import 'package:hangbuddy/pages/routine_run_page.dart';

class RoutineDetailPage extends StatefulWidget {
  const RoutineDetailPage({Key? key, required this.routine}) : super(key: key);

  final RepetitionRoutine routine;

  @override
  _RoutinePageState createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutineDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: TextButton(
          child: const Text('Start'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RoutineRunPage(routine: widget.routine);
            }));
          },
        )));
  }
}
