import 'package:charity/models/user.dart';
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

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  TextEditingController controller = new TextEditingController();
  String selectedChoice = "";

  void handleDonation() {
    Toast.show(Strings.of(context).valueOf("Thank Donation"), context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.transparent);
    Navigator.of(context).pop();
  }

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

  void donate() {
    if (GetIt.I<User>().hasLocation()) {
      if (_formKey.currentState.saveAndValidate()) {
        Toast.show(Strings.of(context).valueOf("Loading"), context,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.BOTTOM,
            backgroundColor: Colors.transparent);
        GetIt.I<FirebaseService>()
            .donate(choice: selectedChoice, desciption: controller.text)
            .whenComplete(handleDonation);
      }
    } else {
      GetIt.I<FirebaseService>().updateLocation();
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
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: appColor,
                  color: appColor,
                  elevation: 7.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed("/offers");
                        },
                        child: Text(
                          Strings.of(context).valueOf("Demands "
                              "List"),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                height: 40.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: appColor,
                  color: appColor,
                  elevation: 7.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: FlatButton(
                        onPressed: () {
                          donate();
                        },
                        child: Text(
                          Strings.of(context).valueOf("Donate"),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        )),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ]),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: new Text(Strings.of(context).valueOf("Donate"),
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
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /* AnimatedContainer(
                  padding: EdgeInsets.only(top: 30),
                  duration: new Duration(seconds: 1),
                  width: _iconAnimationController.value * 200,
                  height: _iconAnimationController.value * 200,
                  alignment: Alignment.center,
                  curve: Curves.decelerate,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/offers");
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: appColor,
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.list,
                            color: Colors.white,
                          ),
                          Text(
                            Strings.of(context).valueOf("Demands "
                                "List"),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ),*/
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: new FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            FormBuilderChoiceChip(
                              decoration: InputDecoration.collapsed(hintText:""),
                                onChanged: (choice) {
                                  setState(() {
                                    this.selectedChoice = choice;
                                  });
                                },
                                alignment: WrapAlignment.center,
                                spacing: 30,
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: Strings.of(context)
                                          .valueOf("Select Choice"))
                                ],
                                attribute: "choice",
                                options: choices
                                    .map((choix) => FormBuilderFieldOption(
                                          value: choix,

                                          child: Text(
                                            Strings.of(context).valueOf(choix),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 20
                                            ),
                                          ),
                                        ))
                                    .toList()),
                            SizedBox(
                              height: 50,
                            ),
                            FormBuilderTextField(
                              controller: controller,
                              minLines: 1,
                              maxLines: 5,
                              validators: selectedChoice == "Other"
                                  ? [
                                      FormBuilderValidators.required(
                                          errorText: Strings.of(context)
                                              .valueOf("Enter Description"))
                                    ]
                                  : [],
                              style: TextStyle(color: Colors.white),
                              initialValue: "",
                              decoration: InputDecoration(
                                  labelText: Strings.of(context)
                                      .valueOf("DESCRIPTION"),
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),

                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)
                                  ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                              keyboardType: TextInputType.text,
                              attribute: "description",
                            ),
                          ],
                        ))),
              ]),
        ]));
  }
}
