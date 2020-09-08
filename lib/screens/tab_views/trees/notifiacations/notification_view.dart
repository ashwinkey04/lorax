import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/enums/icon_enum.dart';
import 'package:lorax/models/notification.dart';
import 'package:lorax/screens/tab_views/gardening/GardenAppBar.dart';
import 'package:lorax/screens/tab_views/trees/delete_icon.dart';
import 'package:scoped_model/scoped_model.dart';

import 'add_notifcation.dart';
import 'notification_empty_state.dart';
import 'notification_grid_view.dart';

class NotificationView extends StatefulWidget {
  String treeId;
  NotificationView(this.treeId);

  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height / 1.3;
    NotificationModel model;
    return ScopedModel<NotificationModel>(
      model: model = NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          backgroundColor: Colors.green[400],
        ),
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
                  child: ScopedModelDescendant<NotificationModel>(
                    builder: (context, child, model) {
                      return Stack(children: <Widget>[
                        buildNotificationView(model),
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

  FutureBuilder buildNotificationView(model) {
    return FutureBuilder(
      future: model.getMedicineList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data.length == 0) {
            return Center(child: NotificationEmptyState());
          }
          return NotificationGridView(snapshot.data, widget.treeId);
        }
        return (Container());
      },
    );
  }

  void buildBottomSheet(double height, NotificationModel model) async {
    var NotificationId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            AddNotification(
                height, model.getDatabase(), model.notificationManager),
          );
        });

    if (NotificationId != null) {
      Fluttertoast.showToast(
          msg: "The Notification was added!",
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
