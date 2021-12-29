import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hangbuddy/entities/repetition_routine.dart';
import 'package:http/http.dart' as http;

class RoutineSearchPage extends StatefulWidget {
  const RoutineSearchPage({Key? key}) : super(key: key);

  @override
  _RoutineSearchPageState createState() => _RoutineSearchPageState();
}

class _RoutineSearchPageState extends State<RoutineSearchPage> {
  var _isSearchBarOpen = false;
  final _myIPAddress = '192.168.86.228'; // TODO: replace this with your IP

  late Future<List<RepetitionRoutine>> _routines;

  @override
  void initState() {
    _routines = _fetchRoutines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: _buildSearchBar()), body: _buildFutureList());
  }

  Widget _buildFutureList() {
    return FutureBuilder<List<RepetitionRoutine>>(
      future: _routines,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildList(snapshot.data!);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildList(List<RepetitionRoutine> routines) {
    return ListView.builder(
        itemCount: routines.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(routines[index].name),
            subtitle: Text(routines[index].prettyTotalTime()),
          );
        });
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: TextField(
          onEditingComplete: () {},
          onSubmitted: (val) {
            setState(() {
              _routines = _fetchRoutines(searchTerm: val);
            });
          },
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  setState(() {
                    _isSearchBarOpen = !_isSearchBarOpen;
                  });
                },
              ),
              hintText: 'Search...',
              border: InputBorder.none),
        ),
      ),
    );
  }

  Future<List<RepetitionRoutine>> _fetchRoutines({String? searchTerm}) async {
    var url = 'http://${_myIPAddress}:3000/routines';
    if (searchTerm != null && searchTerm != '') {
      url += "?name_like=" + searchTerm;
    }

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return RepetitionRoutine.fromJsonList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }
}
