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
  int food=0;
  int sanitary=0;
  int liquidity=0;
  int cleaning=0;
  List<Item> other=new List<Item>();
  bool foodLoaded=false;
  bool sanitaryLoaded=false;
  bool liquidityLoaded=false;
  bool cleaningLoaded=false;
  bool otherLoaded=false;
  void handleFood(value){
    setState(() {
      food=value;
      foodLoaded=true;
    });
  }
  void handleSanitary(value){
    setState(() {
      sanitary=value;
      sanitaryLoaded=true;
    });
  }  void handleLiquidity(value){
    setState(() {
      liquidity=value;
      liquidityLoaded=true;
    });
  }  void handleCleaning(value){
    setState(() {
      cleaning=value;
      cleaningLoaded=true;
    });
  }  void handleOther(value){
    setState(() {
      other=value;
      otherLoaded=true;
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
    return !foodLoaded && !sanitaryLoaded&& !liquidityLoaded &&
        !cleaningLoaded &&!otherLoaded;
  }

  bool isEmpty() {
    return !isLoading() && food==0 && sanitary==0 && liquidity==0 &&
        cleaning==0 && other.length==0;
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
                      "No need!\nDonate whatever you want",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView(
                    children: [
                  new Text(food.toString() + " Food",textAlign:
                  TextAlign.center,),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  new Text(sanitary.toString() + " Sanitary"),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  new Text(liquidity.toString() + " Liquidity"),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  new Text(cleaning.toString() + " Cleaning"),
                  Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  for (var oth in other) new Text(oth.description),
                ]));
  }
}
