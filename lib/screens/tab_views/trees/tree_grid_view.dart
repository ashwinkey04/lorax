import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/tree.dart';
import 'package:lorax/screens/tab_views/trees/edit_tree.dart';
import 'tree_card.dart';
import 'package:scoped_model/scoped_model.dart';

class TreeGridView extends StatelessWidget {
  final List<TreesTableData> list;
  TreeGridView(this.list);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height/1.3;
    return ScopedModelDescendant<TreesModel>(
        builder: (context, child, model) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: list.map((medicine) {
          return InkWell(
            onTap: () {
              buildBottomSheet(deviceHeight, model, context, medicine);
            },
            child: buildLongPressDraggable(medicine, model),
          );
        }).toList(),
      );
    });
  }

  void buildBottomSheet(double height, TreesModel model, BuildContext context, TreesTableData medicine) async {
    var treeId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            EditTree(height, model.getDatabase(), model.notificationManager, medicine),
          );
        });

    if (treeId != null) {
      Fluttertoast.showToast(
          msg: "The Tree was added!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Theme.of(context).accentColor,
          textColor: Colors.white,
          fontSize: 20.0);
    }
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
