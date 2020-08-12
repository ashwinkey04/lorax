import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Lorax',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Login()
    );
  }
}