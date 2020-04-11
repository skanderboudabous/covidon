import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:charity/utils/const.dart';
import 'package:internationalization/internationalization.dart';

class LinkUtils extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(Strings.of(context).valueOf("Link Utils"),
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
        fit: StackFit.expand,
        children: <Widget>[
          new Image(
            image: new AssetImage("assets/images/login_back.jpg"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          ListView(
            //iconColor: Colors.white,
            //textColor: Colors.white,

            children: <Widget>[
              Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Image(image: AssetImage('assets/images/samu.png'),),
                  title: Text(Strings.of(context).valueOf("SAMU") + "     190",

                      style: TextStyle(fontSize: 25,fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,color: Colors.white)),
                  onTap: () {
                    call("190");
                  },
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Image(image: AssetImage('assets/images/covid.png'),),
                  title: Text(
                      Strings.of(context).valueOf("COVID") + "     80101919",
                      style: TextStyle(fontSize: 25,fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,color: Colors.white)),
                  onTap: () {
                    call("80101919");
                  },
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Image(image: AssetImage('assets/images/police.png'),),
                  title:
                      Text(Strings.of(context).valueOf("POLICE") + "     197",
                          style: TextStyle(fontSize: 25,fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,color: Colors.white)),
                  onTap: () {
                    call("197");
                  },
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Image(image: AssetImage('assets/images/guard.png'),),
                  title: Text(Strings.of(context).valueOf("Garde National") +
                      "     193",style: TextStyle(fontSize: 25,fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold,color: Colors.white)),
                  onTap: () {
                    call("193");
                  },
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 50,
                  ),
                ),
              ),
              Card(
                color: Colors.transparent,
                child: ListTile(
                  leading: Image(image: AssetImage('assets/images/protection_civile.png'),),
                  title: Text(
                    Strings.of(context).valueOf("Protection civile") +
                        "     198",
                    style: TextStyle(fontSize: 25,fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                  onTap: () {
                    call("198");
                  },
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 50,
                  ),

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
