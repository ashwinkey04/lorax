import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/notifications/NotificationManager.dart';
import 'package:lorax/screens/tab_views/trees/tree_spinner.dart';

class AddTree extends StatefulWidget {
  final double height;
  final AppDatabase _database;
  final NotificationManager manager;

  AddTree(this.height, this._database, this.manager);

  @override
  _AddTreeState createState() => _AddTreeState();
}

class _AddTreeState extends State<AddTree> {
  static final _formKey = new GlobalKey<FormState>();
  String _name;
  String _description;

  int _selectedIndex = 0;
  List<String> _icons = [
    'tree1.png',
    'tree2.png',
    'tree3.png',
    'tree4.png',
    'tree5.png',
    'tree6.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
        height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add New Tree',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // back to main screen
                    Navigator.pop(context, null);
                  },
                  child: Icon(
                    Icons.close,
                    size: 30,
                    color: Theme.of(context).primaryColor.withOpacity(.65),
                  ),
                )
              ],
            ),
            _buildForm(),
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Type',
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            _buildShapesList(),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  _submit(widget.manager);
                },
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                highlightColor: Theme.of(context).primaryColor,
                child: Text(
                  'Add Tree'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildShapesList() {
    return Container(
      width: double.infinity,
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _icons
            .asMap()
            .entries
            .map((MapEntry map) => _buildIcons(map.key))
            .toList(),
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TreeSpinner(),
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
            ),
            validator: (input) =>
                (input.length > 50) ? 'description is long' : null,
            onSaved: (input) => _description = input,
          )
        ],
      ),
    );
  }

  void _submit(NotificationManager manager) async {
    if (_formKey.currentState.validate()) {
      // form is validated
      _formKey.currentState.save();
      _name = TreeSpinner.dropdownValue;
      print(_name);
      print(_description);
      // insert into database
      var treeId, notificationId;
      DatabaseReference ref = FirebaseDatabase.instance.reference();
      int i = 0;
      String treeName = _name;
      treeId = await widget._database.insertTree(TreesTableData(
          name: treeName,
          description: _description,
          image: 'assets/images/' + _icons[_selectedIndex]));
      ref.child('trees').child(treeName).once().then((DataSnapshot snap) async {
        var keys = snap.value.keys;
        var data = snap.value;
        for (var key in keys) {
          i = i + 1;

          notificationId = await widget._database.insertNotification(NotifyTableData(
              title: data[key]["title"],
              name: treeId.toString(),
              description: data[key]["sub"],
              image: 'assets/images/' + _icons[_selectedIndex]));


          DateTime dateTime = DateTime.now();
          dateTime = new DateTime(dateTime.year, dateTime.month,
              dateTime.day + i, dateTime.hour, dateTime.minute);
          print("count " + i.toString());

          manager.showNotificationOnce(
              notificationId, data[key]["title"], data[key]["sub"], dateTime);
          print('New Tree id' + notificationId.toString());
        }
        Navigator.pop(context, treeId);
      });

    }
  }
  
  Widget _buildIcons(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: (index == _selectedIndex)
              ? Theme.of(context).accentColor.withOpacity(.4)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Image.asset('assets/images/' + _icons[index]),
      ),
    );
  }
}

extension MyDateUtils on DateTime {
  DateTime copyWith(
      {int year,
      int month,
      int day,
      int hour,
      int minute,
      int second,
      int millisecond,
      int microsecond}) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
