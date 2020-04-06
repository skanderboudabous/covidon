import 'package:charity/utils/const.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import 'package:toast/toast.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  TextEditingController controller = new TextEditingController();
  String selectedChoice = "";
  void handleDonation(){
    Toast.show(
        "Thank you for your donation", context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.transparent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
                      if (_formKey.currentState.saveAndValidate()) {
                        GetIt.I<FirebaseService>()
                            .donate(
                                choice: selectedChoice,
                                desciption: controller.text)
                            .whenComplete(handleDonation);
                      }
                    },
                    child: Text(
                      'Donate',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat'),
                    )),
              ),
            ),
          ),
        ),
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: new Text("Donate",
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
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: new FormBuilder(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed("/offers");
                              },
                              child: Container(
                                height: 50,
                                width: 100,
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
                                      "Offers List",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FormBuilderChoiceChip(
                                onChanged: (choice) {
                                  setState(() {
                                    this.selectedChoice = choice;
                                  });
                                },
                                alignment: WrapAlignment.center,
                                spacing: 5,
                                validators: [
                                  FormBuilderValidators.required(
                                      errorText: "Please select a choice")
                                ],
                                attribute: "choice",
                                options: choices
                                    .map((choix) => FormBuilderFieldOption(
                                          value: choix,
                                          child: Text(
                                            choix,
                                            textAlign: TextAlign.center,
                                          ),
                                        ))
                                    .toList()),
                            SizedBox(
                              height: 10,
                            ),
                            FormBuilderTextField(
                              controller: controller,
                              minLines: 1,
                              maxLines: 5,
                              validators: selectedChoice == "Other"
                                  ? [
                                      FormBuilderValidators.required(
                                          errorText:
                                              "Please enter your description")
                                    ]
                                  : [],
                              style: TextStyle(color: Colors.white),
                              initialValue: "",
                              decoration: InputDecoration(
                                  labelText: 'DESCRIPTION',
                                  labelStyle: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green))),
                              keyboardType: TextInputType.text,
                              attribute: "description",
                            ),
                          ],
                        ))),
              ]),
        ]));
  }
}
