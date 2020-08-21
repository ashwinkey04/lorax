import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:lorax/database/moor_database.dart';

class GardeneingCard extends StatelessWidget {
  final GardeningTableData garden;
  final Color color;

  GardeneingCard(this.garden, this.color);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: color,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "         " + garden.description.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: w * .034,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: <Widget>[
                    Text("                           "),
                    Icon(FlutterIcons.alarm_add_mdi),
                    Text(
                      "  " + garden.alarmTime + "   ",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: w * .034,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
