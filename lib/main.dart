import 'package:charity/screens/charity_menu.dart';
import 'package:charity/screens/collection.dart';
import 'package:charity/screens/donate.dart';
import 'package:charity/screens/login.dart';
import 'package:charity/screens/take.dart';
import 'package:charity/utils/const.dart';
import 'package:charity/utils/fbService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'models/user.dart';
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
      home: _getLandingPage(),
    );
  }

  Widget _getLandingPage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        ConnectionState con = snapshot.connectionState;
        if (con == ConnectionState.active) {
          GetIt.I.reset();
          GetIt.I.registerSingleton<FirebaseService>(FirebaseService());
          if (snapshot.hasData) {
            FirebaseUser user = snapshot.data;
            GetIt.I.registerSingleton<User>(User(
                name: user.displayName, userId: user.uid, email: user.email));
            if (snapshot.data.email == adminEmail) {
              return Collection();
            }
            return CharityMenu();
          }
          return LoginPage();
        } else {
          return Scaffold(
            body: new Stack(fit: StackFit.expand, children: <Widget>[
              new Image(
                image: new AssetImage("assets/images/login_back.jpg"),
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black87,
              ),
            ]),
          );
        }
      },
    );
  }
}
