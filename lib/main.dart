import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lorax/screens/home/home_page.dart';
import 'package:lorax/screens/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lorax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: isLoggedIn() != null ? HomePage() : LoginPage(),
    );
  }

  Future<bool> isLoggedIn() async {
    var _user = await _auth.currentUser();
    if (_user == null) {
      return false;
    }
    return true;
  }
}