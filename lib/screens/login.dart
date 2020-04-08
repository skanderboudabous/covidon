import 'package:charity/models/user.dart';
import 'package:charity/ui/con_bar.dart';
import 'package:charity/utils/const.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:internationalization/internationalization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin(User user) {
    print(user == null);
    if (user == null) {
      Toast.show(Strings.of(context).valueOf("Wrong Info"), context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM,
          backgroundColor: Colors.transparent);
    } else {
      print(user.toJson());
      if (user.email == adminEmail) {
        Navigator.of(context).pushNamed("/collection");
      } else {
        Navigator.of(context).pushNamed("/menu");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: new Stack(fit: StackFit.expand, children: <Widget>[
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
            child: Stack(children: [
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          FormBuilderTextField(
                            focusNode: emailNode,
                            onFieldSubmitted: (value) {
                              emailNode.unfocus();
                              passwordNode.requestFocus();
                            },
                            controller: emailController,
                            decoration: InputDecoration(
                                labelText: Strings.of(context).valueOf("EMAIL"),
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
                          FormBuilderTextField(
                            maxLines: 1,
                            focusNode: passwordNode,
                            controller: passwordController,
                            decoration: InputDecoration(
                                labelText:
                                    Strings.of(context).valueOf("PASSWORD"),
                                labelStyle: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                            validators: [
                              FormBuilderValidators.minLength(8,
                                  errorText: Strings.of(context).valueOf("Enter Password"))
                            ],
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            attribute: "password",
                          ),
                          SizedBox(height: 50.0),
                          GestureDetector(
                            onTap: () {
                              if (_formKey.currentState.saveAndValidate()) {
                                Toast.show(Strings.of(context).valueOf("Connecting"), context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM,
                                    backgroundColor: Colors.transparent);
                                GetIt.I
                                    .get<FirebaseService>()
                                    .login(emailController.text,
                                        passwordController.text)
                                    .then((value) => handleLogin(value));
                              }
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
                                    Strings.of(context).valueOf("Sign in"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            height: 40.0,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                      width: 1.0),
                                  color: appColor,
                                  borderRadius: BorderRadius.circular(20.0)),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/signup');
                                },
                                child: Center(
                                  child: Text(Strings.of(context).valueOf("Sign up"),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat')),
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
              ConBar()
            ]),
          ),
        ),
      ]),
    );
  }
}
