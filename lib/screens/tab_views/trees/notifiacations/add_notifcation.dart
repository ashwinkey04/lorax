import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/notifications/NotificationManager.dart';

class AddNotification extends StatefulWidget {
  final double height;
  final AppDatabase _database;
  final NotificationManager manager;

  AddNotification(this.height, this._database, this.manager);

  @override
  _AddNotificationState createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
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
        padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
        height: widget.height * .8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Add New Notification',
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
                  'Add Notification'.toUpperCase(),
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
    TextStyle labelsStyle =
        TextStyle(fontWeight: FontWeight.w400, fontSize: 25);
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length < 5) ? 'Name is short' : null,
            onSaved: (input) => _name = input,
          ),
          TextFormField(
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: 'Description',
              labelStyle: labelsStyle,
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
      print(_name);
      print(_description);
      //show the time picker dialog
      showTimePicker(
        initialTime: TimeOfDay.now(),
        context: context,
      ).then((selectedTime) async {
        int hour = selectedTime.hour;
        int minute = selectedTime.minute;
        print(selectedTime);
        // insert into database
        var notificationId = await widget._database.insertNotification(
            NotifyTableData(
                name: "Papaya",
                title: _name,
                description: _description,
                image: 'assets/images/' + _icons[_selectedIndex]));
        // sehdule the notification
        manager.showNotificationDaily(notificationId, _name, _description, hour, minute);
        // The Tree Id and Notitfaciton Id are the same
        print('New Notification id' + notificationId.toString());
        // go back
        Navigator.pop(context, notificationId);
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
