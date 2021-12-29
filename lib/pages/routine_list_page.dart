import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';
import 'package:hangbuddy/entities/routine_list.dart';
import 'package:hangbuddy/pages/new_routine_sheet.dart';
import 'package:hangbuddy/pages/routine_detail_page.dart';
import 'package:localstorage/localstorage.dart';

class RoutineListPage extends StatefulWidget {
  const RoutineListPage({Key? key}) : super(key: key);

  @override
  _RoutineListPageState createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  final LocalStorage _storage = LocalStorage('hangbuddy.json');
  final RoutineList _routineList = RoutineList();
  bool _initialized = false;

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
          onPressed: _showBottomSheet,
        ),
        body: _buildList());
  }

  Widget _buildList() {
    return FutureBuilder(
        future: _storage.ready,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          if (!_initialized) {
            var data = _storage.getItem('myRoutines');
            if (data != null) {
              _routineList.routines = List<RepetitionRoutine>.from(
                  (data as List)
                      .map((routine) => RepetitionRoutine.fromJson(routine)));
              _initialized = true;
            }
          }

          return ListView.builder(
              itemCount: _routineList.routines.length,
              itemBuilder: (BuildContext context, int index) {
                var routine = _routineList.routines[index];

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
                    onDismissed: (DismissDirection direction) async {
                      try {
                        _deleteRoutine(routine);
                      } catch (e) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Failed to delete: $e"),
                        ));
                      }
                    },
                    child: ListTile(
                      title: Text(routine.name),
                      subtitle:
                          Text("Total time: " + routine.prettyTotalTime()),
                      onTap: () {
                        _pushRoutinePage(routine);
                      },
                    ));
              });
        });
  }

  void _addRoutine(RepetitionRoutine routine) {
    setState(() {
      _routineList.routines.add(routine);
      _saveRoutines();
    });
  }

  void _deleteRoutine(RepetitionRoutine routine) {
    setState(() {
      _routineList.routines.remove(routine);
      _saveRoutines();
    });
  }

  void _saveRoutines() {
    _storage.setItem('myRoutines', _routineList.toJSONEncodable());
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewRoutineSheet(
            onSave: (routine) async {
              try {
                _addRoutine(routine);
              } catch (e) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Failed to save: $e"),
                ));
              }
            },
          );
        });
  }

  void _pushRoutinePage(RepetitionRoutine routine) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RoutineDetailPage(routine: routine);
    }));
  }
}
