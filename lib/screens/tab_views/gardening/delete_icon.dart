import 'package:flutter/material.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/garden.dart';
import 'package:scoped_model/scoped_model.dart';

class DeleteIcon extends StatefulWidget {
  Color color = Colors.grey;
  @override
  _DeleteIconState createState() => _DeleteIconState();
}

class _DeleteIconState extends State<DeleteIcon> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 20,
        left: 100,
        right: 100,
        child: ScopedModelDescendant<GardeningModel>(
            builder: (context, child, model) {
              return DragTarget<GardeningTableData>(
                builder: (context, rejectedData, candidtateData) {
                  return FadeAnimation(
                    .5,
                    Container(
                      width: 250,
                      height: 220,
                      color: Colors.transparent,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Icon(
                          Icons.delete,
                          color: widget.color,
                          size: 60,
                        ),
                      ),
                    ),
                  );
                },
                onWillAccept: (garden) {
                  print('onWillAccept was called');
                  setState(() {
                    widget.color = Colors.red;
                  });
                  return true;
                },
                onLeave: (v) {
                  setState(() {
                    widget.color = Colors.grey;
                  });
                  print('onLeave');
                },
                onAccept: (garden) {
                  // remove it from the database
                  model.getDatabase().deleteGarden(garden);
                  //remove the medicine notifcation
                  model.notificationManager.removeReminder(garden.id);
                  // for debugging
                  print("Garden plans deleted" + garden.toString());
                  // show delete snackbar
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text(
                        'Garden plans deleted',
                        style: TextStyle(fontSize: 20),
                      ),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
              );
            }));
  }
}
