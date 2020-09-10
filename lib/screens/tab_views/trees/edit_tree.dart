import 'package:flutter/material.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/notifications/NotificationManager.dart';

class EditTree extends StatefulWidget {
  final double height;
  final AppDatabase _database;
  final NotificationManager manager;
  final TreesTableData medicine;
  EditTree(this.height, this._database, this.manager, this.medicine);

  @override
  _EditTreeState createState() => _EditTreeState();
}

class _EditTreeState extends State<EditTree> {
  static final _formKey = new GlobalKey<FormState>();
  String _name;
  String _description;
  var txtName = TextEditingController();
  var txtDesc = TextEditingController();

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
                  'Edit Tree Details',
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
                  _submit(widget.manager, widget.medicine);
                },
                color: Theme.of(context).accentColor,
                textColor: Colors.white,
                highlightColor: Theme.of(context).primaryColor,
                child: Text(
                  'Save Changes'.toUpperCase(),
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
            controller: txtName,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: widget.medicine.name,
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length < 5) ? 'Name is short' : null,
            onSaved: (input) => _name = input,
          ),
          TextFormField(
            controller: txtDesc,
            style: TextStyle(fontSize: 25),
            decoration: InputDecoration(
              labelText: widget.medicine.description,
              labelStyle: labelsStyle,
            ),
            validator: (input) => (input.length > 50) ? 'description is long' : null,
            onSaved: (input) => _description = input,
          )
        ],
      ),
    );
  }

  void _submit(NotificationManager manager, TreesTableData medicine) async {
    if (_formKey.currentState.validate()) {
      // form is validated
      _formKey.currentState.save();
      print(_name);
      print(_description);
        await widget._database.updateTree(
            TreesTableData(
                id: medicine.id,
                name: _name,
                description: _description,
                image: 'assets/images/' + _icons[_selectedIndex]));
        final treeId = medicine.id;
        // The Tree Id and Notitfaciton Id are the same
        print('New Tree id' + treeId.toString());
        // go back
        Navigator.pop(context, treeId);
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
