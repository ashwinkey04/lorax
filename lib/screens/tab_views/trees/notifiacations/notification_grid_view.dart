import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/database/moor_database.dart';
import 'package:lorax/models/notification.dart';
import 'package:lorax/screens/tab_views/trees/notifiacations/edit_notification.dart';
import 'package:scoped_model/scoped_model.dart';

import 'notification_card.dart';

class NotificationGridView extends StatelessWidget {
  final List<NotifyTableData> list;
  NotificationGridView(this.list);

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height/1.3;
    return ScopedModelDescendant<NotificationModel>(
        builder: (context, child, model) {
      return GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: list.map((notification) {
          return InkWell(
            onTap: () {
              buildBottomSheet(deviceHeight, model, context, notification);
            },
            child: buildLongPressDraggable(notification, model),
          );
        }).toList(),
      );
    });
  }

  void buildBottomSheet(double height, NotificationModel model, BuildContext context, NotifyTableData notification) async {
    var treeId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            EditNotification(height, model.getDatabase(), model.notificationManager, notification),
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

  LongPressDraggable<NotifyTableData> buildLongPressDraggable(notification, NotificationModel model) {
    if(notification.name == "papaya") {
      return LongPressDraggable<NotifyTableData>(
        data: notification,
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
            child: NotificationCard(notification, Colors.white),
          ),
        ),
        childWhenDragging: Container(
          color: Color(0xff3EB16E).withOpacity(.3),
        ),
        feedback: Card(
          child: NotificationCard(notification, Colors.transparent),
        ),
      );
    }
  }
}
