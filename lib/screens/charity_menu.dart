import 'package:charity/models/user.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:internationalization/internationalization.dart';

class CharityMenu extends StatefulWidget {
  @override
  _CharityMenuState createState() => _CharityMenuState();
}

class _CharityMenuState extends State<CharityMenu> {
  @override
  void initState() {
    if (!GetIt.I<User>().hasLocation())
      GetIt.I<FirebaseService>().updateLocation();
    super.initState();
  }

  void showAboutUsDialogue() {
    showDialog(
      context: context,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          backgroundColor: Colors.white,child: Column(
          children: <Widget>[
            Image(image: new AssetImage("assets/images/app_logo.png"),
              width: 150,),
            SizedBox(
              height: 20,
            ),
            Text("Charity",style: TextStyle(color: Colors.black),),
            Text("1.0",style: TextStyle(color: Colors.black)),
            SizedBox(
              height: 20,
            ),
            Text("This application is developed by",style: TextStyle(color:
            Colors.black)),
            Text("Mohamed Mseddi",style: TextStyle(color: Colors.black)),
            Text("mseddi"
                ".mohamed@iit.ens.tn",style: TextStyle(color: Colors.black)),
            Text("Skander Boudabous",style: TextStyle(color: Colors.black)),
            Text("skander.boudabous@iit.ens.tn",style: TextStyle(color:
            Colors.black))
          ],
        ),);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          Strings.of(context).valueOf("Welcome") +
              " " +
              GetIt.I<User>().firstName,
          overflow: TextOverflow.clip,
        ),
        centerTitle: true,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).pushNamed("/aboutus");
            },
          )
        ],
        leading: IconButton(
          icon: logoutIcon,
          onPressed: () {
            GetIt.I<FirebaseService>()
                .logout();
          },
        ),
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
                    Navigator.of(context).pushNamed('/donate');
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: donateBtnColors,
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
//                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        Strings.of(context).valueOf("Donate"),
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
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
//                constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        Strings.of(context).valueOf("TakeSeek"),
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
