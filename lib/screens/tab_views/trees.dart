
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/enums/icon_enum.dart';
import 'package:lorax/models/notification.dart';
import 'package:lorax/models/tree.dart';
import 'package:lorax/screens/tab_views/trees/add_tree.dart';
import 'package:lorax/screens/tab_views/trees/delete_icon.dart';
import 'package:lorax/screens/tab_views/trees/tree_empty_state.dart';
import 'package:lorax/screens/tab_views/trees/tree_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';

class Trees extends StatefulWidget {
  @override
  _TreesState createState() => _TreesState();
}

class _TreesState extends State<Trees> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height/1.3;
    TreesModel model;
    return ScopedModel<TreesModel>(
      model: model = TreesModel(),
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              buildBottomSheet(deviceHeight, model);
            },
            child: Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
            backgroundColor: Theme.of(context).accentColor,
          ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ScopedModelDescendant<TreesModel>(
                    builder: (context, child, model) {
                      return Stack(children: <Widget>[
                        buildTreesView(model),
                        (model.getCurrentIconState() == DeleteIconState.hide)
                            ? Container()
                            : DeleteIcon()
                      ]);
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }

  FutureBuilder buildTreesView(model) {
    return FutureBuilder(
      future: model.getMedicineList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data.length == 0) {
            // No data
            return Center(child: TreesEmptyState());
          }
          return TreeGridView(snapshot.data);
        }
        return (Container());
      },
    );
  }

  void buildBottomSheet(double height, TreesModel model) async {
    var treeId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            AddTree(height, model.getDatabase(), model.notificationManager),
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

      setState(() {});
    }
  }
}