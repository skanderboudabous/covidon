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
        backgroundColor: appcolor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Product :"),
                Text(
                  GetIt.I<User>().email,
                  overflow: TextOverflow.clip,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Quantity :"),
                Text(
                  item.product,
                  overflow: TextOverflow.clip,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text("Product :"),
                Text(
                  item.product,
                  overflow: TextOverflow.clip,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
