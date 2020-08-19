import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lorax/animations/fade_animation.dart';
import 'package:lorax/enums/icon_enum.dart';
import 'package:lorax/models/garden.dart';
import 'package:lorax/screens/tab_views/gardening/add_plant.dart';
import 'package:lorax/screens/tab_views/gardening/delete_icon.dart';
import 'package:lorax/screens/tab_views/gardening/garden_empty_state.dart';
import 'package:lorax/screens/tab_views/gardening/garden_grid_view.dart';
import 'package:scoped_model/scoped_model.dart';

class Gardening extends StatefulWidget {
  @override
  _GardeningState createState() => _GardeningState();
}

class _GardeningState extends State<Gardening> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    GardeningModel model;
    return ScopedModel<GardeningModel>(
      model: model = GardeningModel(),
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
                  child: ScopedModelDescendant<GardeningModel>(
                    builder: (context, child, model) {
                      return Stack(children: <Widget>[
                        buildGardenView(model),
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

  FutureBuilder buildGardenView(model) {
    return FutureBuilder(
      future: model.getGardenList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          if (snapshot.data.length == 0) {
            // No data
            return Center(child: GardenEmptyState());
          }
          return GardenGridView(snapshot.data);
        }
        return (Container());
      },
    );
  }

  void buildBottomSheet(double height, GardeningModel model) async {
    var gardenId = await showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(45), topRight: Radius.circular(45))),
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return FadeAnimation(
            .6,
            AddGarden(height, model.getDatabase(), model.notificationManager),
          );
        });

    if (gardenId != null) {
      Fluttertoast.showToast(
          msg: "Gardening plan was added!",
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