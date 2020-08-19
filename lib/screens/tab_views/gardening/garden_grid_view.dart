import 'package:flutter/material.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/garden.dart';
import 'gardening_card.dart';
import 'package:scoped_model/scoped_model.dart';

class GardenGridView extends StatelessWidget {
  final List<GardeningTableData> list;
  GardenGridView(this.list);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<GardeningModel>(
        builder: (context, child, model) {
          return GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: list.map((garden) {
              return InkWell(
                onTap: () {
                  // details screen
                },
                child: buildLongPressDraggable(garden, model),
              );
            }).toList(),
          );
        });
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
          margin: EdgeInsets.all(10),
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
