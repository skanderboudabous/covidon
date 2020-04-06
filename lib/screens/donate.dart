import 'package:charity/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  List<String> choices = ["Food", "Sanitary", "Liquidity", "Cleaning", "Other"];
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("HH:mm");
    return new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 40.0,
              child: Material(
                borderRadius: BorderRadius.circular(20.0),
                shadowColor: appColor,
                color: appColor,
                elevation: 7.0,
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.saveAndValidate()) {
                      print(_formKey.currentState.value);
                    }
                  },
                  child: Center(
                    child: Text(
                      'Donate',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    ),
                  ),
                ),
              )),
        ),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: new Text("Donate",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: appColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: Icon(Icons.subdirectory_arrow_left),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: new Stack(fit: StackFit.expand, children: <Widget>[
          new Image(
            image: new AssetImage("assets/images/login_back.jpg"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          SingleChildScrollView(
            child: Column(children: [
              Container(
                  padding:
                      EdgeInsets.symmetric( horizontal: 30),
                  child: new FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FormBuilderTextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'PRODUCT',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.green)),
                            ),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "Please enter your product")
                            ],
                            keyboardType: TextInputType.text,
                            attribute: "product",
                          ),
                          SizedBox(height: 10.0),
                          FormBuilderTextField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'QUANTITY',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "please enter the quantity")
                            ],
                            keyboardType: TextInputType.number,
                            attribute: "quantity",
                          ),
                          SizedBox(height: 10.0),
                          FormBuilderChoiceChip(
                              alignment: WrapAlignment.center,
                              spacing: 5,
                              validators: [
                                FormBuilderValidators.required(
                                    errorText: "Please select a choice")
                              ],
                              attribute: "choice",
                              options: choices
                                  .map((choice) => FormBuilderFieldOption(
                                        value: choice,
                                        child: Container(
                                            width: choice.length <= 5
                                                ? 60
                                                : 80,
                                            margin: EdgeInsets.all(5),
                                            constraints: BoxConstraints(
                                                maxWidth: 80,
                                                minWidth: 60,
                                                maxHeight: 20),
                                            child: Text(
                                              choice,
                                              textAlign: TextAlign.center,
                                            )),
                                      ))
                                  .toList()),
                          SizedBox(height: 10.0),
                          FormBuilderDateTimePicker(
                              inputType: InputType.time,
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "Please select the time")
                            ],
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: "TIME",
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                            format: format,
                            attribute: "dispo",
                          ),
                        ],
                      ))),
            ]),
          ),
        ]));
  }
}
