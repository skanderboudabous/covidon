import 'package:charity/models/user.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  int took;
  int donated;

  @override
  void initState() {
    if (!GetIt.I<User>().hasLocation())
      GetIt.I<FirebaseService>().updateLocation();
    itemsCollection
        .where("completed", isEqualTo: true)
        .where("type", isEqualTo: "Take")
        .getDocuments()
        .then((value) => handleTook(value));
    itemsCollection
        .where("completed", isEqualTo: true)
        .where("type", isEqualTo: "Donation")
        .getDocuments()
        .then((value) => handleDonated(value));
    super.initState();
  }

  handleTook(QuerySnapshot value) {
    setState(() {
      took = value.documents.length;
    });
  }

  handleDonated(QuerySnapshot value) {
    setState(() {
      donated = value.documents.length;
    });
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
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                child: Text(
                  GetIt.I<User>().firstName[0],
                  style: TextStyle(fontSize: 24),
                ),
                radius: 20,
                backgroundColor: Colors.grey,
              ),
              accountEmail: Text(GetIt.I<User>().email),
              accountName: Text(GetIt.I<User>().fullName()),
              decoration: BoxDecoration(
                  color: appColor,
                  image: DecorationImage(
                      image: new AssetImage("assets/images/login_back.jpg"),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black87, BlendMode.darken))),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).pushNamed("/link");
              },
              leading: linkUtilsIcon,
              title: Text(Strings.of(context).valueOf("Link Utils")),
            ),
            ListTile(
              leading: covidStatsIcon,
              onTap: () {
                Navigator.of(context).pushNamed("/covid");
              },
              title: Text(Strings.of(context).valueOf("Covid Stats")),
            ),
            ListTile(
              leading: aboutUsIcon,
              onTap: () {
                Navigator.of(context).pushNamed("/aboutus");
              },
              title: Text(Strings.of(context).valueOf("About")),
            ),
            took == null
                ? SizedBox()
                : ListTile(
                    leading: Image.asset(
                      "assets/images/take.png",
                      color: Colors.grey,
                      width: 30,
                    ),
                    title: Text(took.toString()+" "+Strings.of(context).valueOf("Demands")),
                  ),
            donated == null
                ? SizedBox()
                : ListTile(
                    leading: Image.asset(
                      "assets/images/donate.png",
                      color: Colors.grey,
                      width: 30,
                    ),
                    title: Text(donated.toString()+" "+Strings.of(context)
                        .valueOf("Donation")+"s"),
                  ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ListTile(
                  onTap: () {
                    GetIt.I<FirebaseService>().logout();
                  },
                  leading: logoutIcon,
                  title: Text(Strings.of(context).valueOf("Logout")),
                ),
              ),
            )
          ],
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
