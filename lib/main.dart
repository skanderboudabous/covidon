import 'package:charity/screens/charity_menu.dart';
import 'package:charity/screens/collections.dart';
import 'package:charity/utils/const.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        body: Center(
            child: new Collection()
        ),
      )
    );
  }
}