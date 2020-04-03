import 'package:flutter/material.dart';

void main() => runApp(new Charity());

class Charity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;

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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                 hintStyle: new TextStyle(color: Colors.teal, fontSize: 20.0),

              )),
          isMaterialAppTheme: true,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedContainer(
                  duration: new Duration(seconds: 5),
                  width: _iconAnimationController.value * 150,
                  height: _iconAnimationController.value * 100,
                  alignment: Alignment.center,
                  curve: Curves.bounceOut,
                  child: Image(
                      image: new AssetImage("assets/images/logoIIT.png")
                  )
              ),
              new Container(
                padding: const EdgeInsets.all(30.0),
                child: new Form(
                  autovalidate: true,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new TextFormField(
                        decoration: new InputDecoration(
                            hintText: " Username or Email", fillColor: Colors.white),
                        keyboardType: TextInputType.emailAddress,
                      ),

                      new TextFormField(
                        decoration: new InputDecoration(
                          hintText: "Password",
                        ),
                        obscureText: true,
                        keyboardType: TextInputType.text,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                      new MaterialButton(
                        height: 50.0,
                        minWidth: 150.0,
                        color: Colors.teal,
                        textColor: Colors.white,
                        child: new Text("Login"),
                        onPressed: () {},
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                      ),
                      new MaterialButton(
                          height: 50.0,
                          minWidth: 150.0,
                          color: Colors.teal,
                          textColor: Colors.white,
                          child: new Text("Register"),
                          onPressed: () {})
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
