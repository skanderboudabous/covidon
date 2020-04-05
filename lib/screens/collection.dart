import 'package:charity/models/item.dart';
import 'package:charity/ui/item_card.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  List<Item> items = [
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Take",
        unity: "piece"),
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Take",
        unity: "piece"),
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Take",
        unity: "piece"),
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
    new Item(
        userId: "azeaz",
        product: "Mouse",
        dispoTime: "12:30",
        quantity: 1,
        type: "Donation",
        unity: "piece"),
  ];

  @override
  void initState() {
    GetIt.I<FirebaseService>().updateLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: appColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: logoutIcon,
            onPressed: () {
              GetIt.I<FirebaseService>().logout().whenComplete(
                  () => Navigator.of(context).pushNamed("/login"));
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: ListView.separated(
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
          ),
        ));
  }
}
