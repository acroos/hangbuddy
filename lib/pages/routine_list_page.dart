import 'package:flutter/material.dart';
import 'package:hangbuddy/components/dismissible_list_item.dart';
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

                return DismissibleListItem(
                    item: routine,
                    title: routine.name,
                    subtitle: "Total time: " + routine.prettyTotalTime(),
                    onDismissed: () => _deleteRoutine(routine),
                    onTapped: () => _pushRoutinePage(routine));
              });
        });
  }

  void _addRoutine(RepetitionRoutine routine) {
    try {
      setState(() {
        _routineList.routines.add(routine);
        _saveRoutines();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to save: $e"),
      ));
    }
  }

  void _deleteRoutine(RepetitionRoutine routine) {
    try {
      setState(() {
        _routineList.routines.remove(routine);
        _saveRoutines();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete: $e"),
      ));
    }
  }

  void _saveRoutines() {
    _storage.setItem('myRoutines', _routineList.toJSONEncodable());
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return NewRoutineSheet(onSave: _addRoutine);
        });
  }

  void _pushRoutinePage(RepetitionRoutine routine) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RoutineDetailPage(routine: routine);
    }));
  }
}
