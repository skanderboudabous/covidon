import 'package:charity/models/item.dart';
import 'package:charity/ui/demand_cards.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internationalization/internationalization.dart';

class DemandsList extends StatefulWidget {
  @override
  _DemandsListState createState() => _DemandsListState();
}

class _DemandsListState extends State<DemandsList> {
  List<Item> food = new List<Item>();
  List<Item> sanitary = new List<Item>();
  List<Item> drugs = new List<Item>();
  List<Item> cleaning = new List<Item>();
  List<Item> other = new List<Item>();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    GetIt.I<FirebaseService>().getAll().then((value) => handleAll(value));
    super.initState();
  }

  void handleAll(List<Item> value) {
    setState(() {
      value.forEach((element) {
        switch (element.choice) {
          case "Food":
            food.add(element);
            break;
          case "Sanitary":
            sanitary.add(element);
            break;
          case "Drugs":
            drugs.add(element);
            break;
          case "Cleaning":
            cleaning.add(element);
            break;
          case "Other":
            other.add(element);
            break;
        }
      });
      isLoading=false;
    });
  }

  bool isEmpty() {
    return !isLoading &&
        food.length == 0 &&
        sanitary.length == 0 &&
        drugs.length == 0 &&
        cleaning.length == 0 &&
        other.length == 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          centerTitle: true,
          title: new Text(Strings.of(context).valueOf("Demands"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold)),
        ),
        body: isLoading
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : isEmpty()
                ? new Center(
                    child: Text(
                      Strings.of(context).valueOf("Donate Anything"),
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Stack(fit: StackFit.expand,

                  children: <Widget>[
                    new Image(
                      image: new AssetImage("assets/images/login_back.jpg"),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                      color: Colors.black87,
                    ),
                    Column(children: [
                       DemandCards(items: food, choice: "Food",),
                       DemandCards(items: sanitary, choice: "Sanitary",),
                       DemandCards(items: drugs, choice: "Drugs",),
                       DemandCards(items: cleaning, choice: "Cleaning",),
                       DemandCards(items: other, choice: "Other",),
                      ]),
                  ],
                ));
  }
}
