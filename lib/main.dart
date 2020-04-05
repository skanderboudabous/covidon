import 'package:charity/screens/charity_menu.dart';
import 'package:charity/screens/collection.dart';
import 'package:charity/screens/loading_screen.dart';
import 'package:charity/screens/donate.dart';
import 'package:charity/screens/take.dart';
import 'package:flutter/material.dart';
import 'screens/signup.dart';

void main() => runApp(new Charity());

class Charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signup': (BuildContext context) => new SignupPage(),
        '/menu': (BuildContext context) => new CharityMenu(),
        '/donate': (BuildContext context) => new DonatePage(),
        '/take': (BuildContext context) => new TakePage(),
        '/collection': (BuildContext context) => new Collection()
      },
      theme: new ThemeData(primarySwatch: Colors.blue),
      home:new LoadingScreen(),
    );
  }
}
