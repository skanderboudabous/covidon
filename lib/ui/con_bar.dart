import 'package:charity/utils/styles.dart';
import 'package:connection_status_bar/connection_status_bar.dart';
import 'package:flutter/material.dart';

class ConBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConnectionStatusBar(color: appColor,),
    );
  }
}
