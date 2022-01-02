import 'package:flutter/material.dart';

class DismissibleListItem<T> extends StatelessWidget {
  const DismissibleListItem(
      {Key? key,
      required this.item,
      required this.title,
      required this.subtitle,
      required this.onDismissed,
      required this.onTapped})
      : super(key: key);

  final T item;
  final String title;
  final String subtitle;
  final void Function() onDismissed;
  final void Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        direction: DismissDirection.endToStart,
        background: Container(
            alignment: const Alignment(1.0, 0.0),
            padding: const EdgeInsets.all(16.0),
            color: Colors.red,
            child: const Text(
              'Swipe to delete',
              textAlign: TextAlign.end,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            )),
        key: ValueKey<T>(item),
        onDismissed: (direction) => onDismissed,
        child: ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          onTap: onTapped,
        ));
  }
}
