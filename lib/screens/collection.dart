import 'package:charity/models/item.dart';
import 'package:charity/ui/item_card.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Collection extends StatefulWidget {
  @override
  _CollectionState createState() => _CollectionState();
}

class _CollectionState extends State<Collection> {
  final refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

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
        title: new Text("Welcome Admin",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: appColor,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed("/history");
            },
          )
        ],
        leading: IconButton(
          icon: logoutIcon,
          onPressed: () {
            GetIt.I<FirebaseService>()
                .logout()
                .whenComplete(() => Navigator.of(context).pushNamed("/login"));
          },
        ),
      ),
      body: WillPopScope(
          onWillPop: () async => false,
          child: StreamBuilder(
            stream: itemsCollection
                .where("completed", isEqualTo: false)
                .orderBy("timestamp", descending: true)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.data!=null && snapshot.data.documents.length!=0) {
                List<DocumentSnapshot> items = snapshot.data.documents;
                return RefreshIndicator(
                  key: refreshIndicatorKey,
                  onRefresh: _handleRefresh,
                  child: ListView(
                      children: items
                          .map((e) => ItemCard(
                                item: Item.fromMap(e.data),
                              ))
                          .toList()),
                );
              } else {
                return Center(child: Text("There is no demands",style:
                TextStyle(fontSize: 20),
                ),);
              }
            },
          )),
    );
  }
  Future<Null> _handleRefresh() async {
    print("refreshing");
    return null;
  }
}
