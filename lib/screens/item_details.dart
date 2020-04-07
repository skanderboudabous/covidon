import 'package:charity/models/item.dart';
import 'package:charity/models/user.dart';
import 'package:charity/ui/map.dart';
import 'package:charity/ui/user_card.dart';
import 'package:charity/utils/fbService.dart';
import 'package:charity/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
        title: Text(widget.item.type),
        centerTitle: true,
        backgroundColor: appColor,
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
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: UserCard(
                        user: user,
                        choice: widget.item.choice,
                      ),
                    ),

                  ],
                ),
              ),
      ),
    );
  }
}
