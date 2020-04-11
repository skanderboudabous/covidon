import 'package:charity/utils/const.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';

class CovidView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  EasyWebView(
      src: covidUrl,
    );
  }
}
