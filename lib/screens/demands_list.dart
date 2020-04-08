import 'package:charity/models/item.dart';
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
  int food = 0;
  int sanitary = 0;
  int liquidity = 0;
  int cleaning = 0;
  List<Item> other = new List<Item>();
  bool foodLoaded = false;
  bool sanitaryLoaded = false;
  bool liquidityLoaded = false;
  bool cleaningLoaded = false;
  bool otherLoaded = false;

  void handleFood(value) {
    setState(() {
      food = value;
      foodLoaded = true;
    });
  }

  void handleSanitary(value) {
    setState(() {
      sanitary = value;
      sanitaryLoaded = true;
    });
  }

  void handleLiquidity(value) {
    setState(() {
      liquidity = value;
      liquidityLoaded = true;
    });
  }

  void handleCleaning(value) {
    setState(() {
      cleaning = value;
      cleaningLoaded = true;
    });
  }

  void handleOther(value) {
    setState(() {
      other = value;
      otherLoaded = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    GetIt.I<FirebaseService>().getFood().then((value) => handleFood(value));
    GetIt.I<FirebaseService>()
        .getSanitary()
        .then((value) => handleSanitary(value));
    GetIt.I<FirebaseService>()
        .getLiquidity()
        .then((value) => handleLiquidity(value));
    GetIt.I<FirebaseService>()
        .getCleaning()
        .then((value) => handleCleaning(value));
    GetIt.I<FirebaseService>().getOther().then((value) => handleOther(value));
    super.initState();
  }

  bool isLoading() {
    return !foodLoaded &&
        !sanitaryLoaded &&
        !liquidityLoaded &&
        !cleaningLoaded &&
        !otherLoaded;
  }

  bool isEmpty() {
    return !isLoading() &&
        food == 0 &&
        sanitary == 0 &&
        liquidity == 0 &&
        cleaning == 0 &&
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
        body: isLoading()
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
                : ListView(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 0.5),
                        gradient: LinearGradient(
                          colors: takeSeekColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Text(
                        food.toString() +
                            " " +
                            Strings.of(context).valueOf("Food"),
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(fontSize: 30, fontFamily: "Montserrat"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 0.5),
                        gradient: LinearGradient(
                          colors: takeSeekColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Text(
                        sanitary.toString() +
                            " " +
                            Strings.of(context).valueOf("Sanitary"),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 30, fontFamily: "Montserrat"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 0.5),
                        gradient: LinearGradient(
                          colors: takeSeekColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Text(
                        liquidity.toString() +
                            " " +
                            Strings.of(context).valueOf("Liquidity"),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 30, fontFamily: "Montserrat"),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black87, width: 0.5),
                        gradient: LinearGradient(
                          colors: takeSeekColors,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Text(
                        cleaning.toString() +
                            " " +
                            Strings.of(context).valueOf("Cleaning"),
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontSize: 30, fontFamily: "Montserrat"),
                      ),
                    ),
                    for (var oth in other)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black87, width: 0.5),
                          gradient: LinearGradient(
                            colors: takeSeekColors,
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                        child: Text(
                          "1 "+oth.description,
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                              fontSize: 30, fontFamily: "Montserrat"),
                        ),
                      )
                  ]));
  }
}
