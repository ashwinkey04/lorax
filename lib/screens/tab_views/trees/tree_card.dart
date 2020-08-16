import 'package:flutter/material.dart';
import 'package:lorax/database/moor_database.dart';

class TreeCard extends StatelessWidget {
  final TreesTableData tree;
  final Color color;

  TreeCard(this.tree, this.color);

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
          Container(
            margin: EdgeInsets.all(10),
            width: 50,
            height: 50,
            child: Hero(
              tag: tree.name,
              child: Image.asset(
                tree.image,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text(
                  tree.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: width * .06),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                tree.description.toUpperCase(),
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
