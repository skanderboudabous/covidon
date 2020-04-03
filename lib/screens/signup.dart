import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd-MM-yyyy");
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: new Stack(fit: StackFit.expand, children: <Widget>[

          new Image(
            image: new AssetImage("assets/images/login_back.jpg"),
            fit: BoxFit.cover,
            colorBlendMode: BlendMode.darken,
            color: Colors.black87,
          ),
          Container(
          padding: EdgeInsets.only(top: 40.0),
            child: new Text("Register",
                textAlign: TextAlign.center,
                style: TextStyle(
                color: Colors.teal,
                fontSize: 40.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold
            )),
          ),
          Container(
              padding: EdgeInsets.only(top: 90.0, left: 30.0, right: 30.0),
              child: new Form(
                  autovalidate: true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            labelText: 'FULL NAME ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green)),
                            ),
                        validator: validateName,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            labelText: 'EMAIL',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            labelText: 'PASSWORD ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: validatePassword,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            labelText: 'USERNAME ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10.0),
                      DateTimeField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                          labelText: 'DATE OF BIRTH',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey)
                        ),
                        format: format,
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        style: TextStyle(
                          color: Colors.white
                        ),
                        decoration: InputDecoration(
                            labelText: 'Phone Number ',
                            labelStyle: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green))),
                        validator: validateMobile,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 50.0),
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
                                  'SIGNUP',
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
        ]));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  String validateName(String value) {
    if (value.length < 5)
      return 'Name must be more than 5 charater';
    else
      return null;
  }
  String validateUserName(String value) {
    if (value.length < 5)
      return 'Username must be more than 5 charater';
    else
      return null;
  }
  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be more than 8 charater';
    else
      return null;
  }
  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 8)
      return 'Mobile Number must be of 8 digit';
    else
      return null;
  }

}
