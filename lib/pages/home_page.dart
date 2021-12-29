import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';
import 'package:hangbuddy/pages/routine_list_page.dart';
import 'package:hangbuddy/pages/routine_search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = [
    const RoutineSearchPage(),
    RoutineListPage(routines: [
      RepetitionRoutine(
          name: '7x3 Repeaters', hangTime: 7, restTime: 3, repetitions: 1),
      RepetitionRoutine(
          name: '4x10s', hangTime: 10, restTime: 50, repetitions: 4)
    ])
  ];

  var _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Mine')
            ],
            selectedItemColor: Theme.of(context).primaryColor,
            currentIndex: _selectedIndex,
            onTap: (tab) {
              setState(() {
                _selectedIndex = tab;
              });
            }));
  }
}
