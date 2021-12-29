import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';
import 'package:numberpicker/numberpicker.dart';

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
    const _spacer = SizedBox(height: 16.0);
    final _textStyle = Theme.of(context).textTheme.headline6;

    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('New Routine', style: Theme.of(context).textTheme.headline5),
            _spacer,
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                  hintText: 'My New Routine'),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            _spacer,
            Column(
              children: [
                Text('Hang Time', style: _textStyle),
                NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 0,
                    maxValue: 1000,
                    value: _hangTime,
                    onChanged: (value) {
                      setState(() {
                        _hangTime = value;
                      });
                    }),
              ],
            ),
            _spacer,
            Column(
              children: [
                Text('Rest Time', style: _textStyle),
                NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 0,
                    maxValue: 1000,
                    value: _restTime,
                    onChanged: (value) {
                      setState(() {
                        _restTime = value;
                      });
                    }),
              ],
            ),
            _spacer,
            Column(
              children: [
                Text('Repetitions', style: _textStyle),
                NumberPicker(
                    axis: Axis.horizontal,
                    minValue: 0,
                    maxValue: 1000,
                    value: _repetitions,
                    onChanged: (value) {
                      setState(() {
                        _repetitions = value;
                      });
                    }),
              ],
            ),
            _spacer,
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
