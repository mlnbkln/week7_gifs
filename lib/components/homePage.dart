import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:week7_gifs/components/gifs.dart';
import 'package:week7_gifs/helpers/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _gifsUrl = <String>[];
  GifsFetch _gifsFetch = GifsFetch();

  void updateData(gifData) {
    setState(() {
      if (gifData != null) {
        debugPrint("from homePage updateData:");
        debugPrint(jsonEncode(gifData));
        for (int i = 0; i < numberOfGifs; i++) {
          _gifsUrl.add(
              gifData["data"][i]["images"]["fixed_width"]["url"].toString());
        }
      } else {
        for (int i = 0; i < numberOfGifs; i++) {
          _gifsUrl.add(defaultGif);
        }
      }
    });
  }

  _getGifs(searchString) async {
    debugPrint("from homePage _getGifs:");
    debugPrint(searchString);
    _gifsUrl.clear();
    try {
      var dataDecoded;
      if (searchString != "") {
        dataDecoded = await _gifsFetch.getGifs(searchString);
      }
      updateData(dataDecoded);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: "Search"),
                  onSubmitted: (String searchString) => _getGifs(searchString),
                ),
                if (_gifsUrl.isNotEmpty)
                  Expanded(
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          height: 600,
                          child: ListView.builder(
                              itemCount: _gifsUrl.length ~/ 2,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(children: [
                                  Image.network(
                                    _gifsUrl[index * 2],
                                    width: 180,
                                  ),
                                  Image.network(
                                    _gifsUrl[index * 2 + 1],
                                    width: 180,
                                  ),
                                ]);
                              })))
              ],
            ),
          ),
        ));
  }
}
