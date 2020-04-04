import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  int selectedIndex = -1;
  List<String> choices = ["Kilogram", "Litre", "Piece"];

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("HH:mm");
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: new AssetImage("assets/images/login_back.jpg"),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.black87, BlendMode.darken)),
          ),
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 60.0),
              child: new Text("Donate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 40.0,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold)),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                  padding: EdgeInsets.only(top: 90.0, left: 30.0, right: 30.0),
                  child: new Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'PRODUCT',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green)),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter product';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: 'QUANTITY',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter quantity';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 10.0),
                      Wrap(children: choices.map((e) => new ChoiceChip(label:
                      Text(e), selected: selectedIndex==choices.indexOf(e),
                          onSelected: (value){
                          setState(() {
                            selectedIndex=choices.indexOf(e);
                          });
                          },))
                          .toList()
                      ),
                      SizedBox(height: 10.0),
                      DateTimeField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelText: "DISPO TIME",
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        format: format,
                        onShowPicker: (context, currentValue) async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                currentValue ?? DateTime.now()),
                          );
                          return DateTimeField.convert(time);
                        },
                      ),
                      SizedBox(height: 20.0),
                      Container(
                          height: 40.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.tealAccent,
                            color: Colors.teal,
                            elevation: 7.0,
                            child: GestureDetector(
                              onTap: () {},
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
                      SizedBox(height: 20.0),
                      Container(
                        height: 40.0,
                        color: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.white,
                                  style: BorderStyle.solid,
                                  width: 1.0),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Center(
                              child: Text('Go Back',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat')),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))),
            ),
          ]),
        ));
  }
}
