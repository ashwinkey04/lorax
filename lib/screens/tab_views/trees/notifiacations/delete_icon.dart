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
        child: ScopedModelDescendant<NotificationModel>(
            builder: (context, child, model) {
          return DragTarget<NotifyTableData>(
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
            onAccept: (notification) {
              // remove it from the database
              model.getDatabase().deleteNotification(notification);
              //remove the medicine notifcation
              model.notificationManager.removeReminder(notification.id);
              // for debugging
              print("Notification deleted" + notification.toString());
              // show delete snackbar
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    'Notification deleted',
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
