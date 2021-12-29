import 'package:flutter/material.dart';
import 'package:hangbuddy/pages/home_page.dart';

void main() {
  runApp(const HangBuddyApp());
}

class HangBuddyApp extends StatelessWidget {
  const HangBuddyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HangBuddy',
        theme: ThemeData(primarySwatch: Colors.amber),
        home: const HomePage());
  }
}
