import 'package:charity/screens/about_us.dart';
import 'package:charity/screens/charity_menu.dart';
import 'package:charity/screens/collection.dart';
import 'package:charity/screens/donate.dart';
import 'package:charity/screens/forgot_password.dart';
import 'package:charity/screens/history.dart';
import 'package:charity/screens/item_details.dart';
import 'package:charity/screens/loading_screen.dart';
import 'package:charity/screens/login.dart';
import 'package:charity/screens/demands_list.dart';
import 'package:charity/screens/take.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internationalization/internationalization.dart';

import 'screens/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Internationalization.loadConfigurations();
  runApp(new Charity());
}

class Charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      supportedLocales: suportedLocales,
      localizationsDelegates: [
        Internationalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      title: "Charity",
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => new LoadingScreen(),
        "/details": (BuildContext context) =>
            new ItemDetails(item: ModalRoute.of(context).settings.arguments),
        "/aboutus":(BuildContext context)=> new AboutUs(),
        "/history": (BuildContext context) => new History(),
        "/offers": (BuildContext context) => new DemandsList(),
        "/login": (BuildContext context) => new LoginPage(),
        '/signup': (BuildContext context) => new SignupPage(),
        '/menu': (BuildContext context) => new CharityMenu(),
        '/donate': (BuildContext context) => new DonatePage(),
        '/take': (BuildContext context) => new TakePage(),
        '/collection': (BuildContext context) => new Collection(),
        '/forgot_password': (BuildContext context) =>new ForgotPassPage()
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
