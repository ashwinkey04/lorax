import 'package:flutter/material.dart';
import 'package:lorax/screens/profile/profile_page.dart';
import 'package:lorax/screens/tab_views/gardening.dart';
import 'package:lorax/screens/tab_views/trees.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../plictionary.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.green,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.account_circle,
              ),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Plictionary();
                          },
                        ),
                      );
                    },
                    child: Icon(FlutterIcons.dictionary_mco),
                  )
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(FlutterIcons.tree_mco)),
                Tab(icon: Icon(FlutterIcons.tree_ent))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Gardening(),
              Trees(),
            ],
          ),
        ),
      ),
    );
  }
}
