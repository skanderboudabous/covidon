import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
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
          ListTileTheme(
            iconColor: Colors.white,
            textColor: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("POLICE"),
                  onTap: () {},
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("POLICE"),
                  onTap: () {},
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("POLICE"),
                  onTap: () {},
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("POLICE"),
                  onTap: () {},
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.directions_car),
                  title: Text("POLICE"),
                  onTap: () {},
                  trailing: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
