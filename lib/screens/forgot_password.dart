import 'package:charity/models/user.dart';
import 'package:charity/ui/con_bar.dart';
import 'package:charity/utils/const.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:internationalization/internationalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  State createState() => new ForgotPassPageState();
}

class ForgotPassPageState extends State<ForgotPassPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  final _formKey = new GlobalKey<FormBuilderState>();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final FocusNode emailNode = new FocusNode();
  final FocusNode passwordNode = new FocusNode();

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
    handlePreferences();
  }
  void handlePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("email")) {
      emailController.text = prefs.get("email");
    }
  }
  void showResetAlert(){
    showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(title: new Text(Strings.of(context).valueOf
        ("a reset email is sent")),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }, child: new Text(Strings.of(context).valueOf("Ok"),style: TextStyle(color: Colors.green),)),
          ],
          backgroundColor: appColor);
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            new Image(
              image: new AssetImage("assets/images/login_back.jpg"),
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.darken,
              color: Colors.black87,
            ),
            new Theme(
              data: new ThemeData(
                  brightness: Brightness.dark,
                  inputDecorationTheme: new InputDecorationTheme(
                    hintStyle: new TextStyle(color: appColor, fontSize: 20.0),
                  )),
              isMaterialAppTheme: true,
              child: WillPopScope(
                onWillPop: () async => false,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                            duration: new Duration(seconds: 1),
                            width: _iconAnimationController.value * 200,
                            height: _iconAnimationController.value * 200,
                            alignment: Alignment.center,
                            curve: Curves.decelerate,
                            child: Image(
                                image: new AssetImage("assets/images/app_logo.png"))),
                        new Container(
                          padding: const EdgeInsets.all(30.0),
                          child: new FormBuilder(
                            key: _formKey,
                            child: new Column(
                              children: <Widget>[
                                FormBuilderTextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                      labelText:
                                          Strings.of(context).valueOf("EMAIL"),
                                      labelStyle: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                  validators: [
                                    FormBuilderValidators.email(
                                        errorText:
                                            Strings.of(context).valueOf("Enter "
                                                "Email"))
                                  ],
                                  keyboardType: TextInputType.emailAddress,
                                  attribute: "email",
                                ),
                                SizedBox(height: 50.0),
                                GestureDetector(
                                  onTap: () {
                                    showResetAlert();
                                  },
                                  child: Container(
                                    height: 40.0,
                                    child: Material(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: appColor,
                                      color: appColor,
                                      elevation: 7.0,
                                      child: Center(
                                        child: Text(
                                          Strings.of(context)
                                              .valueOf("Rest"),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Montserrat'),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
