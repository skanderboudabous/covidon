import 'package:charity/models/user.dart';
import 'package:flutter/material.dart';
import 'package:charity/utils/const.dart';
import 'package:charity/utils/fbService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    GetIt.I.reset();
    GetIt.I.registerSingleton<FirebaseService>(FirebaseService());
    FirebaseAuth.instance.onAuthStateChanged.listen((event) {
      handleUser(event);
    });
    super.initState();
  }

  void handleUser(FirebaseUser user) async {
    if (user != null) {
      User currentUser=await GetIt.I<FirebaseService>().getUserFromId(id: user
          .uid);
      if(currentUser!=null) {
        GetIt.I.registerSingleton<User>(currentUser);
        if (user.email == adminEmail) {
          Navigator.of(context).pushNamed("/collection");
        }
        else {
          Navigator.of(context).pushNamed("/menu");
        }
      }
      else{
        Navigator.of(context).pushNamed("/login");
      }
    } else {
      Navigator.of(context).pushNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(fit: StackFit.expand, children: <Widget>[
      new Image(
        image: new AssetImage("assets/images/login_back.jpg"),
        fit: BoxFit.cover,
        colorBlendMode: BlendMode.darken,
        color: Colors.black87,
      ),
    ]);
  }
}
