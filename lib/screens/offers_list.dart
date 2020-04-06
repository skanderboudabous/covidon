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
  void handleFood(value){
    setState(() {
      food=value;
    });
  }
  void handleSanitary(value){
    setState(() {
      sanitary=value;
    });
  }  void handleLiquidity(value){
    setState(() {
      liquidity=value;
    });
  }  void handleCleaning(value){
    setState(() {
      cleaning=value;
    });
  }  void handleOther(value){
    setState(() {
      other=value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetIt.I<FirebaseService>().getFood().then((value) => handleFood(value));
    GetIt.I<FirebaseService>().getSanitary().then((value) => handleSanitary(value));
    GetIt.I<FirebaseService>().getLiquidity().then((value) => handleLiquidity(value));
    GetIt.I<FirebaseService>().getCleaning().then((value) => handleCleaning(value));
    GetIt.I<FirebaseService>().getOther().then((value) => handleOther(value));
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
