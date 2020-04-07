import 'package:charity/models/item.dart';
import 'package:charity/models/user.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatefulWidget {
  final Item item;

  HistoryCard({this.item});

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  User user;
  bool isLoading = true;

  @override
  void initState() {
    GetIt.I<FirebaseService>()
        .getUserFromId(id: widget.item.userId)
        .then((value) => handleUser(value));
    super.initState();
  }

  void handleUser(User user) {
    setState(() {
      this.user = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('dd-MM');
    return isLoading
    ? SizedBox():Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black87, width: 0.5)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.item.type == "Donation"
                ? donateBtnColors
                : takeSeekColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 4,
                      child: Text(
                        user.firstName + " " + user.lastName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Text(
                        widget.item.type,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Text(
                        widget.item.choice,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Text(
                        formatter.format(
                            new DateTime.fromMillisecondsSinceEpoch(
                                widget.item.timestamp.millisecondsSinceEpoch)),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
            ),
      ),
    );
  }
}
