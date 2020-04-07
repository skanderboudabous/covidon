import 'package:charity/models/item.dart';
import 'package:charity/ui/history_card.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: new Text("History",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      body: StreamBuilder(
        stream: itemsCollection
            .where("completed", isEqualTo: true)
            .orderBy("timestamp", descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data!=null && snapshot.data.documents.length!=0) {
            List<DocumentSnapshot> items = snapshot.data.documents;
            return ListView(
                children: items
                    .map((e) => HistoryCard(
                          item: Item.fromMap(e.data),
                        ))
                    .toList());
          } else {
            return new Center(
              child: Text(
                'History is empty',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25),
              ),
            );
          }
        },
      ),
    );
  }
}
