import 'package:flutter/material.dart';
import 'package:lorax/database/moor_database.dart';

class GardeneingCard extends StatelessWidget {
  final GardeningTableData garden;
  final Color color;

  GardeneingCard(this.garden, this.color);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: 180,
      height: 180,
      color: color,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Text(
                garden.description.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: width * .034,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
