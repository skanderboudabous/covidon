import 'package:charity/models/item.dart';
import 'package:charity/screens/item_details.dart';
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ItemDetails(item: item,)),
        );
      },
      child: Container(
//        padding: EdgeInsets.all(10),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  item.type.toLowerCase() == "donation" ? donateBtnColors :
                  takeSeekColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                      width: 100,
                      constraints: BoxConstraints(maxWidth: 100),
                      child: Text(
                        item.product,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      )),
                  Container(
                      width: 100,
                      height: 50,
                      constraints: BoxConstraints(maxWidth: 100),
                      padding: EdgeInsets.only(top:15),
                      child: Text(
                        item.type,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    width: 100,
                    constraints: BoxConstraints(maxWidth: 100),
                    child: Text(
                      item.dispoTime,
                      textAlign: TextAlign.right,
                    ),
                  )
                ],
              ),
//                Divider(height: 10,thickness: 1,)
            ],
          ),
        ),
      ),
    );
  }
}