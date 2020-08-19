import 'package:flutter/material.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/notifications/NotificationManager.dart';

class AddGarden extends StatefulWidget {
  final double height;
  final AppDatabase _database;
  final NotificationManager manager;
  AddGarden(this.height, this._database, this.manager);

  @override
  _AddGardenState createState() => _AddGardenState();
}

class _AddGardenState extends State<AddGarden> {
  static final _formKey = new GlobalKey<FormState>();
  String _description;


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
                  'Add New plant',
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
                  'Add Plant'.toUpperCase(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ));
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
              labelText: 'Description',
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length > 50) ? 'description is long' : null,
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
        var plantId = await widget._database.insertGarden(
            GardeningTableData(
                description: _description,
                ));
        // scehdule the notification
        manager.showGardenNotificationDaily(plantId,_description, hour, minute);
        // The Plant Id and Notitfaciton Id are the same
        print('New Plant id' + plantId.toString());
        // go back
        Navigator.pop(context, plantId);
      });
    }
  }

}
