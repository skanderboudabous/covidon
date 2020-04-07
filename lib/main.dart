import 'package:charity/screens/charity_menu.dart';
import 'package:charity/screens/collection.dart';
import 'package:charity/screens/donate.dart';
import 'package:charity/screens/history.dart';
import 'package:charity/screens/item_details.dart';
import 'package:charity/screens/loading_screen.dart';
import 'package:charity/screens/login.dart';
import 'package:charity/screens/offers_list.dart';
import 'package:charity/screens/take.dart';
import 'package:flutter/material.dart';

import 'screens/signup.dart';

void main() => runApp(new Charity());

class Charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Charity",
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => new LoadingScreen(),
        "/details": (BuildContext context) =>
            new ItemDetails(item: ModalRoute.of(context).settings.arguments),
        "/history": (BuildContext context) => new History(),
        "/offers": (BuildContext context) => new OffersList(),
        "/login": (BuildContext context) => new LoginPage(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/menu': (BuildContext context) => new CharityMenu(),
        '/donate': (BuildContext context) => new DonatePage(),
        '/take': (BuildContext context) => new TakePage(),
        '/collection': (BuildContext context) => new Collection()
      },
      // ignore: missing_return
      onGenerateRoute: (args) {
        print(args);
        return null;
      },
      theme: new ThemeData(primarySwatch: Colors.blue),
    );
  }
}
