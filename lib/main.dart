import 'file:///E:/FlutterProjects/Charity/charity/lib/screens/donate.dart';
import 'package:charity/screens/login.dart';
import 'package:flutter/material.dart';
import 'screens/signup.dart';

void main() => runApp(new Charity());

class Charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage()
      },
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

