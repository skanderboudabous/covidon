import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:internationalization/internationalization.dart';
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
      Toast.show(Strings.of(context).valueOf("Email Registered"), context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.black);
    } else {
      print(user.uid);
      Navigator.of(context).pushNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              child: Container(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: appColor,
                    color: appColor,
                    elevation: 7.0,
                    child: Center(
                      child: Text(
                        Strings.of(context).valueOf("Sign up"),
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      ),
                    ),
                  )),
              onTap: (){
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
                }
              },
            ),
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
                    child: Text(Strings.of(context).valueOf("Back"),
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
          child: new Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.expand, children: <Widget>[
            new Image(
              image: new AssetImage("assets/images/login_back.jpg"),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              color: Colors.black87,
            ),
            Container(
              padding: EdgeInsets.only(top: 40.0),
              child: new Text(Strings.of(context).valueOf("Register"),
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
                              labelText:
                                  Strings.of(context).valueOf("FIRST NAME"),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText: Strings.of(context)
                                      .valueOf("Enter First"))
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
                              labelText:
                                  Strings.of(context).valueOf("LAST NAME"),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            validators: [
                              FormBuilderValidators.required(
                                  errorText:
                                      Strings.of(context).valueOf("Enter Last"))
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
                              labelText: Strings.of(context).valueOf("EMAIL"),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validators: [
                              FormBuilderValidators.email(
                                  errorText: Strings.of(context)
                                      .valueOf("Enter Email"))
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
                              labelText:
                                  Strings.of(context).valueOf("PASSWORD"),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            validators: [
                              FormBuilderValidators.minLength(8,
                                  errorText: Strings.of(context)
                                      .valueOf("Verify Password"))
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
                              labelText: Strings.of(context).valueOf("PHONE"),
                              labelStyle: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey)),
                            ),
                            validators: [
                              FormBuilderValidators.minLength(8,
                                  errorText: Strings.of(context)
                                      .valueOf("Verify Phone")),
                              FormBuilderValidators.maxLength(8,
                                  errorText: Strings.of(context)
                                      .valueOf("Verify Phone"))
                            ],
                            keyboardType: TextInputType.phone,
                            attribute: "phone",
                          ),
                        ],
                      ))),
            ),
          ]),
        ));
  }
}
