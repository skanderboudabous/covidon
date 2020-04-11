import 'package:charity/models/user.dart';
import 'package:charity/ui/map.dart';
import 'package:charity/utils/const.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class UserCard extends StatelessWidget {
  final User user;
  final String choice;

  UserCard({@required this.user, @required this.choice});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(user.firstName + " " + user.lastName, style: userStyle),
        SizedBox(
          height: 30,
        ),
        Text(
          user.phone,
          style: userStyle,
        ),
        IconButton(
          icon: Icon(
            Icons.phone,
            size: 40,
            color: Colors.green,
          ),
          onPressed: () {
            call(user.phone);
          },
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 60),
          height: 50,
          decoration: BoxDecoration(
              color: appColor,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Center(
              child: Text(
            Strings.of(context).valueOf(choice),
            style: userStyle,
          )),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: IconButton(
            icon: Icon(
              Icons.location_on,
              size: 60,
              color: Colors.red,
            ),
            onPressed: () {
              openMap(context);
            },
          ),
        )
      ],
    );
  }

  void openMap(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: new Map(
                user: user,
              ),
            ),
          );
        });
  }
}
