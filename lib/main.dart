import 'package:flutter/material.dart';

import 'package:week7_gifs/components/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search',
      home: HomePage(),
    );
  }
}
