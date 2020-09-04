import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;
import 'package:lorax/jsonModels/Data.dart';
import 'package:lorax/jsonModels/LinkData.dart';
import 'package:lorax/jsonModels/Meta.dart';
import 'package:lorax/screens/tree_dict/empty_dict.dart';

import 'dict_card.dart';

class Plictionary extends StatefulWidget {
  @override
  _Plictionary createState() => new _Plictionary();
}

class _Plictionary extends State<Plictionary> {
  List<Data> data;
  LinkData links;
  Meta meta;
  var dataNull = true;
  String sq = "";

  Future<String> getData(String query) async {
    FocusScope.of(context).unfocus();
    var client = new http.Client();
    try {
      var queryLink =
          'https://trefle.io/api/v1/plants/search?token=peNaBhmqKnjLb0G67WeBbMW-q0w6HBBXY4_jrDmmOyU&q=$query';
      print(queryLink);
      var response = await client.get(queryLink);
      var parsed = json.decode(response.body);
      if (parsed['data'] != null) {
        data = new List<Data>();
        parsed['data'].forEach((v) {
          data.add(new Data.fromJson(v));
        });
      }
      links = parsed['links'] != null
          ? new LinkData.fromJson(parsed['links'])
          : null;
      meta = parsed['meta'] != null ? new Meta.fromJson(parsed['meta']) : null;

      setState(() {
        dataNull = false;
      });

      //print(meta.total);
      //print(data[0].author); Total number of responses is stored in meta.total
    } finally {
      client.close();
    }
    return "Success!";
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return new Scaffold(
      appBar: AppBar(
        title: Text("Plant Dictionary"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Center(
              child: new Container(
                  padding: const EdgeInsets.all(30.0),
                  color: Colors.white,
                  child: new Container(
                      child: new Center(
                          child: new Column(children: [
                    new Text(
                      'Search for any plant',
                      style: new TextStyle(fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 50.0)),
                    new TextFormField(
                      controller: _controller,
                      decoration: new InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () async => {
                            setState(() {
                              dataNull = true;
                              sq = _controller.text;
                            }),
                            getData(_controller.text),
                          },
                          icon: Icon(FlutterIcons.search_mdi),
                        ),
                        labelText: "Enter Plant Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.text,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ])))),
            ),
            dataNull ? setDictNull() : setDict(),
          ],
        ),
      ),
    );
  }

  Widget setDictNull() {
    return EmptyDict();
  }

  Widget setDict() {
    return Column(
      children: [
        SizedBox(height: 8),
        Center(
          child: new Text(
            '$sq'.toUpperCase(),
            style: new TextStyle(fontSize: 20.0),
          ),
        ),
        ListView.builder(
          primary: false,
          itemCount: data.length,
          shrinkWrap: true,
          itemBuilder: getCard,
          padding: EdgeInsets.all(0.0),
        )
      ],
    );
  }

  Widget getCard(BuildContext context, int index) {
    return new DictCard(data[index].scientificName, data[index].commonName,
        data[index].imageUrl, data[index].genus, data[index].family);
  }
}
