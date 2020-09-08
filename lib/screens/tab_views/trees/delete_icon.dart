import 'package:flutter/material.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/notification.dart';
import 'package:lorax/models/tree.dart';
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
        child: ScopedModelDescendant<TreesModel>(
            builder: (context, child, model) {
          return DragTarget<TreesTableData>(
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
            onWillAccept: (medicine) {
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
            onAccept: (medicine) async{
              // remove it from the database
              model.getDatabase().deleteTree(medicine);
              List<NotifyTableData> list = await NotificationModel().getMedicineList();
              for(var i = 0; i<list.length;i++){
                if(list[i].name == medicine.id.toString()){
                  model.getDatabase().deleteNotification(list[i]);
                  model.notificationManager.removeReminder(list[i].id);
                  print("deleting this"+ list[i].id.toString());
                }
              }              //remove the medicine notifcation
              // for debugging
              print("Tree deleted" + medicine.toString());
              // show delete snackbar
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Tree deleted',
                    style: TextStyle(fontSize: 20),
                  ),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          );
        }));
  }

  getList() async{

  }
}
