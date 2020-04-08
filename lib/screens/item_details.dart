import 'package:charity/models/item.dart';
import 'package:charity/models/user.dart';
import 'package:charity/ui/user_card.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:internationalization/internationalization.dart';

class ItemDetails extends StatefulWidget {
  final Item item;

  ItemDetails({this.item});

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  User user;
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetIt.I<FirebaseService>()
        .getUserFromId(id: widget.item.userId)
        .then((value) => handleUser(value));
  }

  void handleUser(User user) {
    print(user.toMap());
    setState(() {
      this.user = user;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.of(context).valueOf(widget.item.type)),
        centerTitle: true,
        backgroundColor: appColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            height: 40.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid,
                      width: 1.0),
                  color: appColor,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                onTap: () {
                  showCompleteAlert();
                },
                child: Center(
                  child: Text(Strings.of(context).valueOf("Complete"),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
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
                    color: Colors.white,
                      style: BorderStyle.solid,
                      width: 1.0),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                onTap: () {
                  showDeleteAlert();
                },
                child: Center(
                  child: Text(Strings.of(context).valueOf("Delete"),
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: new AssetImage("assets/images/login_back.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken)),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    UserCard(
                      user: user,
                      choice: widget.item.choice,
                    ),

                  ],
                ),
              ),
      ),
    );
  }
  void showCompleteAlert(){
    showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(title: new Text(Strings.of(context).valueOf("Confirm")),
      content: new Text(Strings.of(context).valueOf("Completed Action")),
      actions: <Widget>[
        new FlatButton(onPressed: (){
          complete();
          Navigator.of(context).pop();
        }, child: new Text(Strings.of(context).valueOf("Yes"),style: TextStyle
          (color: Colors.green),)),
        new FlatButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: new Text(Strings.of(context).valueOf("No"),style: TextStyle
          (color: Colors.red),)),
      ],
      backgroundColor: appColor);
    });
  }
  void complete(){
    GetIt.I<FirebaseService>().complete(widget.item.id).whenComplete
      (back);

  }
  void showDeleteAlert(){
    showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(title: new Text(Strings.of(context).valueOf
        ("Confirm")),
          content: new Text(Strings.of(context).valueOf("Delete it")),
          actions: <Widget>[
            new FlatButton(onPressed: (){
              delete();
              Navigator.of(context).pop();
            }, child: new Text(Strings.of(context).valueOf("Yes"),style: TextStyle(color: Colors.green),)),
            new FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: new Text(Strings.of(context).valueOf("No"),style:
            TextStyle(color: Colors.red),)),
          ],
          backgroundColor: appColor);
    });
  }
  void delete(){
    GetIt.I<FirebaseService>().delete(widget.item.id).whenComplete(back);
  }
  void back(){
    Navigator.of(context).pop();
  }
}
