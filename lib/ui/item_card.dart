import 'package:charity/models/item.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Item item;

  ItemCard({@required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
          Navigator.of(context).pushNamed("/details",
              arguments:item);
      },
      child: Container(
        child: Container(
          decoration: BoxDecoration(border:Border.all(color: Colors.black87,
              width: 0.5)),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    item.type == "Donation" ? donateBtnColors :
                    takeSeekColors,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                    flex:1,
                    fit: FlexFit.tight,
                    child: Text(
                      item.choice,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Flexible(
                    flex:1,
                    fit:FlexFit.tight,
                    child: Text(
                      item.type,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
