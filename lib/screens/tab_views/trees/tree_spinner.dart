import 'package:flutter/material.dart';



class TreeSpinner extends StatefulWidget {

  final List<String> treeNamesList;
  TreeSpinner(this.treeNamesList, {Key key}) : super(key: key);
  static String dropdownValue = "papaya";
  @override
  _TreeSpinnerState createState() => _TreeSpinnerState();

}

class _TreeSpinnerState extends State<TreeSpinner> {


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
        items: widget.treeNamesList
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
