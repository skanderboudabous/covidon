import 'package:charity/models/item.dart';
import 'package:charity/models/user.dart';
import 'package:charity/ui/item_card.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  List<Item> items = [
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Take",
        unity: "piece"),
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Take",
        unity: "piece"),
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Take",
        unity: "piece"),
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
    new Item(
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetIt.I.registerSingleton<User>(User(
        email: "azea",
        name: "azeaz",
        phone: ""
            "azeaz",
        userId: "zaeazeaze"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return ItemCard(
              item: items[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              height: 1,
              color: Colors.grey,
              thickness: 2,
            );
          },
          itemCount: items.length,
        ));
  }
}
