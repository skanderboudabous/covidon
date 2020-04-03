import 'package:charity/donate.dart';
import 'package:charity/take.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';

void main() => runApp(new Charity());

class Charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new TakePage(),
    );
  }
}

