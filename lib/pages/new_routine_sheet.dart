import 'package:flutter/material.dart';
import 'package:hangbuddy/components/number_selector.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';

class NewRoutineSheet extends StatefulWidget {
  const NewRoutineSheet({Key? key, required this.onSave}) : super(key: key);

  final Function(RepetitionRoutine) onSave;

  @override
  _NewRoutineSheetState createState() => _NewRoutineSheetState();
}

class _NewRoutineSheetState extends State<NewRoutineSheet> {
  var _name = '';
  var _hangTime = 10;
  var _restTime = 10;
  var _repetitions = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Routine Name',
                  hintText: 'My New Routine'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            NumberSelector(
                title: 'Hang Time',
                value: _hangTime,
                onChanged: (value) {
                  setState(() {
                    _hangTime = value;
                  });
                }),
            NumberSelector(
                title: 'Rest Time',
                value: _restTime,
                onChanged: (value) {
                  setState(() {
                    _restTime = value;
                  });
                }),
            NumberSelector(
                title: 'Repetitions',
                value: _repetitions,
                onChanged: (value) {
                  setState(() {
                    _repetitions = value;
                  });
                }),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    widget.onSave(RepetitionRoutine(
                        name: _name,
                        hangTime: _hangTime,
                        restTime: _restTime,
                        repetitions: _repetitions));
                    Navigator.pop(context);
                  },
                  child: const Text('Save')),
            )
          ],
        ));
  }
}
