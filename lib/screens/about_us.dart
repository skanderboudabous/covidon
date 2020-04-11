import 'package:charity/utils/const.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: new Text(Strings.of(context).valueOf("About"),
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/images/login_back.jpg"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          Padding(
            padding: const EdgeInsets.only(top:100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: new AssetImage("assets/images/app_logo.png"),
                  width: 150,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  TITLE,
                  style: TextStyle(color: Colors.white),
                ),
                Text("1.0", style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 20,
                ),
                Text(Strings.of(context).valueOf("Dev By"),
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text("Mohamed Mseddi", style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "mseddi"
                    ".mohamed@iit.ens.tn",
                    style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text("Skander Boudabous", style: TextStyle(color: Colors.white)),
                SizedBox(
                  height: 10,
                ),
                Text("skander.boudabous@iit.ens.tn",
                    style: TextStyle(color: Colors.white))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
