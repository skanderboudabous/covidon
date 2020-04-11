import 'package:charity/models/item.dart';
import 'package:charity/ui/custom-expansion-tile.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class DemandCards extends StatelessWidget {
  final List<Item> items;
  final String choice;

  DemandCards({@required this.items, @required this.choice});

  //TODO : Prevent Touch from Expansion tile if the list is empty

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87, width: 0.5),
        gradient: LinearGradient(
          colors: takeSeekColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: items.length == 0
          ? AbsorbPointer(
              child: Container(
                width: double.infinity,
                child: Text(
                items.length.toString() +
                    " " +
                    Strings.of(context).valueOf(choice),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30, fontFamily: "Montserrat", color: Colors.black),
            ),
              ))
          : CustomExpansionTile(
              title: Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Text(
                  items.length.toString() +
                      " " +
                      Strings.of(context).valueOf(choice),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: "Montserrat",
                      color: Colors.black),
                ),
              ),
              children: items.map((e) {
                return e.description == ""
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          e.description,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
              }).toList(),
            ),
    );
  }
}
