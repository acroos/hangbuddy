import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';
import 'package:hangbuddy/pages/new_routine_sheet.dart';
import 'package:hangbuddy/pages/routine_detail_page.dart';

class RoutineListPage extends StatefulWidget {
  const RoutineListPage({Key? key, required this.routines}) : super(key: key);

  final List<RepetitionRoutine> routines;

  @override
  _RoutineListPageState createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Routines'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('New Routine'),
          icon: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return NewRoutineSheet(
                    onSave: (routine) {
                      setState(() {
                        widget.routines.add(routine);
                      });
                    },
                  );
                });
          },
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: widget.routines.length,
        itemBuilder: (BuildContext context, int index) {
          var routine = widget.routines[index];

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
              key: ValueKey<RepetitionRoutine>(routine),
              onDismissed: (DismissDirection direction) {
                setState(() {
                  widget.routines.removeAt(index);
                });
              },
              child: ListTile(
                title: Text(routine.name),
                subtitle: Text("Total time: " + routine.prettyTotalTime()),
                onTap: () {
                  _pushRoutinePage(routine);
                },
              ));
        });
  }

  void _pushRoutinePage(RepetitionRoutine routine) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RoutineDetailPage(routine: routine);
    }));
  }
}
