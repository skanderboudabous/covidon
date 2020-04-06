import 'package:charity/models/item.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class OffersList extends StatefulWidget {
  @override
  _OffersListState createState() => _OffersListState();
}

class _OffersListState extends State<OffersList> {
  List<Item> food;
  List<Item> sanitary;
  List<Item> liquidity;
  List<Item> cleaning;
  List<Item> other;

  @override
  void initState() {
    // TODO: implement initState
    GetIt.I<FirebaseService>().getFood().asStream().listen((event) {
      setState(() {
        food = event;
      });
    });
    GetIt.I<FirebaseService>().getSanitary().asStream().listen((event) {
      setState(() {
        sanitary = event;
      });
    });
    GetIt.I<FirebaseService>().getLiquidity().asStream().listen((event) {
      setState(() {
        liquidity = event;
      });
    });
    GetIt.I<FirebaseService>().getCleaning().asStream().listen((event) {
      setState(() {
        cleaning = event;
      });
    });
    GetIt.I<FirebaseService>().getOther().asStream().listen((event) {
      setState(() {
        other = event;
      });
    });

    super.initState();
  }

  bool isLoading() {
    return food == null &&
        sanitary == null &&
        liquidity == null &&
        cleaning == null &&
        other == null;
  }

  bool isEmpty() {
    return (food != null && food.length == 0) &&
        (sanitary != null && sanitary.length == 0) &&
        (liquidity != null && liquidity.length == 0) &&
        (cleaning != null && cleaning.length == 0) &&
        (other != null && other.length == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appColor,
          centerTitle: true,
          title: new Text("Offers",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold)),
        ),
        body: isLoading()
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : isEmpty()
                ? new Center(
                    child: Text(
                      "No offers for now",
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView(
                    children: [
                  new Text(food.length.toString() + " Food",textAlign: TextAlign.center,),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  new Text(sanitary.length.toString() + " Sanitary"),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  new Text(liquidity.length.toString() + " Liquidity"),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  new Text(cleaning.length.toString() + " Cleaning"),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  for (var oth in other) new Text(oth.description),
                ]));
  }
}
