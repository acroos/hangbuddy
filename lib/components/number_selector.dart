import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberSelector extends StatelessWidget {
  const NumberSelector(
      {Key? key,
      required this.title,
      required this.value,
      required this.onChanged})
      : super(key: key);

  final String title;
  final int value;
  final void Function(int) onChanged;

  @override
  Widget build(BuildContext context) {
    final _textStyle = Theme.of(context).textTheme.headline6;

    return Column(
      children: [
        Text(title, style: _textStyle),
        NumberPicker(
            axis: Axis.horizontal,
            minValue: 0,
            maxValue: 1000,
            value: value,
            onChanged: onChanged),
      ],
    );
  }
}
