import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();
  final FocusNode emailNode=new FocusNode();
  final FocusNode passwordNode=new FocusNode();
  final FocusNode firstNameNode=new FocusNode();
  final FocusNode lastNameNode=new FocusNode();
  final FocusNode phoneNode=new FocusNode();

  void handleRegister(FirebaseUser user) {
    if (user == null) {
      print("error");
    } else {
      print(user.uid);
      Navigator.of(context).pushNamed("/login");
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
                  shadowColor: appColor,
                  color: appColor,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState.validate()) {
                        GetIt.I
                            .get<FirebaseService>()
                            .register(
                                emailController.text,
                                passwordController.text,
                                firstNameController.text,
                                lastNameController.text,
                                phoneController.text)
                            .then((value) => handleRegister(value));
                        Navigator.of(context).pushNamed('/');
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
        body: WillPopScope(
          onWillPop: () async => false,
          child: new Stack(fit: StackFit.expand, children: <Widget>[
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
                      color: appColor,
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
                            focusNode: firstNameNode,
                            onFieldSubmitted: (value){
                              firstNameNode.unfocus();
                              lastNameNode.requestFocus();
                            },
                            textCapitalization: TextCapitalization.words,
                            controller: firstNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'FIRST NAME ',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                            ),
                            validator: validateFirstName,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            focusNode: lastNameNode,
                            textCapitalization: TextCapitalization.words,
                            onFieldSubmitted: (value){
                              lastNameNode.unfocus();
                              emailNode.requestFocus();
                            },
                            controller: lastNameController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'LAST NAME ',
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                            ),
                            validator: validateLastName,
                            keyboardType: TextInputType.text,
                          ),
                          SizedBox(height: 10.0),
                          TextFormField(
                            focusNode: emailNode,
                              onFieldSubmitted: (value){
                                  emailNode.unfocus();
                                  passwordNode.requestFocus();
                              },
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
                            focusNode: passwordNode,
                            onFieldSubmitted: (value){
                              passwordNode.unfocus();
                              phoneNode.requestFocus();
                            },
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
                            focusNode: phoneNode,
                            controller: phoneController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                labelText: 'PHONE ',
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
          ]),
        ));
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter a valid Email';
    else
      return null;
  }

  String validateFirstName(String value) {
    if (value.length != 1)
      return 'Please enter your First Name';
    else
      return null;
  }
  String validateLastName(String value) {
    if (value.length != 1)
      return 'Please enter your Last Name';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.length < 8)
      return 'Password must be more than 8 characters';
    else
      return null;
  }

  String validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 8)
      return 'Phone Number must have 8 digits';
    else
      return null;
  }
}
