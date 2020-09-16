import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TreeSpinner extends StatefulWidget {
  TreeSpinner({Key key}) : super(key: key);
  @override
  _TreeSpinnerState createState() => _TreeSpinnerState();
  static String dropdownValue = 'Mango';

}

class _TreeSpinnerState extends State<TreeSpinner>{
  DatabaseReference ref = FirebaseDatabase.instance.reference().child('trees');
  var treesList = ['Mango', 'Papaya', 'Guava', 'Coconut','Banyan','Banana'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
      child: DropdownButton<String>(
        value: TreeSpinner.dropdownValue,
        icon: Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(fontSize: 25, color: Colors.black45),
        isExpanded: true,
        underline: Container(
          height: 2,
          color: Colors.grey,
        ),
        onChanged: (String newValue) {
          setState(() {
            TreeSpinner.dropdownValue = newValue;
          });
        },
        items: treesList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
