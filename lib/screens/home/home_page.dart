import 'package:flutter/material.dart';
import 'package:lorax/screens/profile/profile_page.dart';
import 'package:lorax/screens/tab_views/gardening.dart';
import 'package:lorax/screens/tab_views/trees.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';
import 'package:flutter_keyboard_aware_dialog/flutter_keyboard_aware_dialog.dart';

import '../tree_dict/plictionary.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Home"),
            backgroundColor: Colors.green,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfilePage();
                    },
                  ),
                );
              },
              child: Icon(
                Icons.account_circle,
              ),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return Plictionary();
                          },
                        ),
                      );
                    },
                    child: Icon(FlutterIcons.dictionary_mco),
                  )),
              Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      _optionsDialogBox();
                    },
                    child: Icon(FlutterIcons.camera_ent),
                  )),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(FlutterIcons.tree_mco)),
                Tab(icon: Icon(FlutterIcons.tree_ent))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Gardening(),
              Trees(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _optionsDialogBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyText2,
                      children: [
                        WidgetSpan(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Icon(FlutterIcons.photo_camera_mdi),
                          ),
                        ),
                        TextSpan(
                          text: 'Choose mode',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Take a picture'),
                    onTap: openCamera,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: new Text('Select from gallery'),
                    onTap: openGallery,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> openCamera() async {
    ImagePicker ip = new ImagePicker();
    var picture = await ip.getImage(
      source: ImageSource.camera,
    );
    imageDialog(picture);
    //shareImage(picture);
  }

  Future<void> openGallery() async {
    ImagePicker ip = new ImagePicker();
    var picture = await ip.getImage(
      source: ImageSource.gallery,
    );
    imageDialog(picture);
    //shareImage(picture);
  }

  Future<void> shareImage(PickedFile picture, String sharingMessage) async {
    final pngByteData = await picture.readAsBytes();
    await WcFlutterShare.share(
        sharePopupTitle: 'Share your progress!',
        text: '$sharingMessage',
        fileName: 'share.png',
        mimeType: 'image/png',
        bytesOfFile: pngByteData.buffer.asUint8List(),
        iPadConfig: IPadConfig(
          originX: 0,
          originY: 0,
          originHeight: 0,
          originWidth: 0,
        ));
  }

  Future<void> imageDialog(PickedFile picture) async {
    final pngByteData = await picture.readAsBytes();
    TextEditingController shareMessage = new TextEditingController();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return KeyboardAwareAlertDialog(
            content: Column(
              children: [
                new Text("Share your progress!"),
                Padding(
                  padding: EdgeInsets.all(5.0),
                ),
                new Image.memory(
                  pngByteData,
                  fit: BoxFit.cover,
                ),
                TextFormField(
                  controller: shareMessage
                    ..text =
                        'I am using Lorax to help me track the trees I plant. Try it out! #lets_make_planet_green_again #lorax',
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
                SizedBox(
                  width: 100.0,
                  child: RaisedButton(
                    onPressed: () {
                      shareImage(picture, shareMessage.text);
                    },
                    color: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: <Widget>[
                        Text("Send", style: TextStyle(color: Colors.white)),
                        SizedBox(width: 6),
                        Icon(FlutterIcons.md_share_ion),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
