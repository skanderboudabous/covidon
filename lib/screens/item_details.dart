import 'package:charity/models/item.dart';
import 'package:charity/models/user.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ItemDetails extends StatelessWidget {
  final Item item;

  ItemDetails({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.type),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
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
            children: <Widget>[

            ],
          ),
        ),
      ),
    );
  }
}
