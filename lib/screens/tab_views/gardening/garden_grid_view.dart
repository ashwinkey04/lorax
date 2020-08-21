import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/garden.dart';
import 'package:lorax/screens/tab_views/gardening/edit_garden.dart';
import 'gardening_card.dart';
import 'package:scoped_model/scoped_model.dart';

class GardenGridView extends StatelessWidget {
  final List<GardeningTableData> list;
  GardenGridView(this.list);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height/2;
    return ScopedModelDescendant<GardeningModel>(
        builder: (context, child, model) {
          return GridView.count(
            crossAxisCount: 1,
            childAspectRatio: 4.5,
            shrinkWrap: true,
            children: list.map((garden) {
              return InkWell(
                onTap: () {
                  buildBottomSheet(deviceHeight, model, context, garden);
                },
                child: buildLongPressDraggable(garden, model),
              );
            }).toList(),
          );
        });
  }

  void buildBottomSheet(double height, GardeningModel model, BuildContext context, GardeningTableData medicine) async {
    var treeId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            EditGarden(height, model.getDatabase(), model.notificationManager, medicine),
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

  LongPressDraggable<GardeningTableData> buildLongPressDraggable(
      plant, GardeningModel model) {
    return LongPressDraggable<GardeningTableData>(
      data: plant,
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
          margin: EdgeInsets.all(5),
          child: GardeneingCard(plant, Colors.white),
        ),
      ),
      childWhenDragging: Container(
        color: Color(0xff3EB16E).withOpacity(.3),
      ),
      feedback: Card(
        child: GardeneingCard(plant, Colors.transparent),
      ),
    );
  }
}
