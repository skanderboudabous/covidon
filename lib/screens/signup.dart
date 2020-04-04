import 'package:charity/utils/fbService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  TextEditingController emailController=new TextEditingController();
  TextEditingController passwordController=new TextEditingController();
  TextEditingController nameController=new TextEditingController();
  TextEditingController phoneController=new TextEditingController();
  final _formKey = new GlobalKey<FormState>();


  void handleRegister(FirebaseUser user){
   if(user==null)
     {
       print("error");

     }
   else{
     print(user.uid);

   }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.tealAccent,
                  color: Colors.teal,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        GetIt.I.get<FirebaseService>().register(
                            emailController.text, passwordController
                            .text,nameController.text,phoneController.text)
                            .then((value) =>
                            handleRegister(value));
                      }
                    },
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
        ),
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
                    fontWeight: FontWeight.bold)),
          ),
          SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.only(top: 150.0, left: 30.0, right: 30.0),
                child: new Form(
                  key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          textCapitalization: TextCapitalization.words,
                          controller: nameController,
                          style: TextStyle(color: Colors.white),
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
                          controller: emailController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'EMAIL',
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            keyboardType: TextInputType.emailAddress,
                            validator: validateEmail),
                        SizedBox(height: 10.0),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: passwordController,
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
                          controller: phoneController,
                          style: TextStyle(color: Colors.white),
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
                      ],
                    ))),
          ),
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
