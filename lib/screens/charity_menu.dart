import 'package:charity/models/user.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';

class CharityMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Welcome "+GetIt.I<User>().firstName,overflow: TextOverflow.clip,),
        centerTitle: true,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: logoutIcon,
          onPressed: () {
            GetIt.I<FirebaseService>()
                .logout()
                .whenComplete(() => Navigator.of(context).pushNamed("/login"));
          },
        ),
        actions: <Widget>[
          IconButton(icon: userIcon,
          onPressed: (){

          },)
        ],
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage("assets/images/login_back.jpg"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black87, BlendMode.darken)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 150,
                child: RaisedButton(
                  onPressed: () {
                    print("donate");
                    Navigator.of(context).pushNamed('/donate');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: donateBtnColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
//                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Donate",
                        textAlign: TextAlign.center,
                        style: menuTextStyle,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.0),
              Container(
                width: 200,
                height: 150,
                child: RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/take');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: takeSeekColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
//                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "Take\n&\nSeek",
                        textAlign: TextAlign.center,
                        style: menuTextStyle,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
