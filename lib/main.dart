import 'package:flutter/material.dart';
import 'package:note_app/screens/add_note.dart';
import 'package:note_app/screens/display_note.dart';
import 'package:note_app/screens/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      initialRoute: '/',
      routes: {
        "/": (_) => HomeScreen(),
        "/addNote": (_) => AddNote(),
        "/showNote": (_) => ShowNote(),
      },
    );
  }
}
