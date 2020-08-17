import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lorax/screens/home/home_page.dart';
import 'package:lorax/screens/login/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lorax',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder(
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.hasData)
              return snapshot.data ? HomePage() : LoginPage();
            else
              return Container();
          },
          future: isLoggedIn()),
    );
  }
}

Future<bool> isLoggedIn() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user = await _auth.currentUser();
  log(_user.toString());
  if (_user == null) {
    log("NO");
    return false;
  }
  log("YES");
  return true;
}
