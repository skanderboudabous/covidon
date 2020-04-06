import 'package:charity/ui/con_bar.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';

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
  final _formKey = new GlobalKey<FormBuilderState>();
  final FocusNode emailNode = new FocusNode();
  final FocusNode passwordNode = new FocusNode();
  final FocusNode firstNameNode = new FocusNode();
  final FocusNode lastNameNode = new FocusNode();
  final FocusNode phoneNode = new FocusNode();

  void handleRegister(FirebaseUser user) {
    if (user == null) {
      Toast.show("Email is already registered", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.transparent);
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
                      if (_formKey.currentState.saveAndValidate()) {
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
            ConBar(),
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
                  child: new FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FormBuilderTextField(
                            focusNode: firstNameNode,
                            onFieldSubmitted: (value) {
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
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "Please enter your First Name")
                            ],
                            keyboardType: TextInputType.text,
                            attribute: "firstName",
                          ),
                          SizedBox(height: 10.0),
                          FormBuilderTextField(
                            focusNode: lastNameNode,
                            textCapitalization: TextCapitalization.words,
                            onFieldSubmitted: (value) {
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
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: "Please enter your Last Name")
                            ],
                            keyboardType: TextInputType.text,
                            attribute: "lastName",
                          ),
                          SizedBox(height: 10.0),
                          FormBuilderTextField(
                            focusNode: emailNode,
                            onFieldSubmitted: (value) {
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
                            validators: [
                              FormBuilderValidators.email(
                                  errorText: "Please enter a valid Email")
                            ],
                            attribute: "email",
                          ),
                          SizedBox(height: 10.0),
                          FormBuilderTextField(
                            focusNode: passwordNode,
                            onFieldSubmitted: (value) {
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
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            validators: [
                              FormBuilderValidators.minLength(8,
                                  errorText: "Password must be more than 8 "
                                      "characters")
                            ],
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            maxLines: 1,
                            attribute: "password",
                          ),
                          SizedBox(height: 10.0),
                          FormBuilderTextField(
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
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            validators: [
                              FormBuilderValidators.minLength(8,
                                  errorText: "Phone Number must have 8 digits"),
                              FormBuilderValidators.maxLength(8,
                                  errorText: "Phone Number must have 8 digits")
                            ],
                            keyboardType: TextInputType.phone, attribute: "phone",
                          ),
                        ],
                      ))),
            ),
          ]),
        ));
  }
}
