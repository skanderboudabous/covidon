import 'package:charity/utils/styles.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';
import 'package:internationalization/internationalization.dart';

class ConBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConnectionStatusBar(
        color: appColor,
        title: new Text(
          Strings.of(context).valueOf("Check Connection"),
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}
