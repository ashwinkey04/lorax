import 'package:flutter/material.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/tree.dart';
import 'tree_card.dart';
import 'package:scoped_model/scoped_model.dart';

class TreeGridView extends StatelessWidget {
  final List<TreesTableData> list;
  TreeGridView(this.list);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TreesModel>(
        builder: (context, child, model) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: list.map((medicine) {
          return InkWell(
            onTap: () {
              // details screen
            },
            child: buildLongPressDraggable(medicine, model),
          );
        }).toList(),
      );
    });
  }

  LongPressDraggable<TreesTableData> buildLongPressDraggable(
      tree, TreesModel model) {
    return LongPressDraggable<TreesTableData>(
      data: tree,
      onDragStarted: () {
        // show the delete icon
        model.toggleIconState();
      },
      onDragEnd: (v) {
        // hide the delete icon
        model.toggleIconState();
      },
      child: FadeAnimation(
        .05,
        Card(
          margin: EdgeInsets.all(10),
          child: TreeCard(tree, Colors.white),
        ),
      ),
      childWhenDragging: Container(
        color: Color(0xff3EB16E).withOpacity(.3),
      ),
      feedback: Card(
        child: TreeCard(tree, Colors.transparent),
      ),
    );
  }
}
