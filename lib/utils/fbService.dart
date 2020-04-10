import 'package:charity/models/item.dart';
import 'package:charity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocation/geolocation.dart';
import 'package:get_it/get_it.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final usersCollection = Firestore.instance.collection("users");
final itemsCollection = Firestore.instance.collection("items");

class FirebaseService {
  Future<User> login(String email, String password) async {
    final authResult = (await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) => print(error.toString())));
    if (authResult == null) return null;
    FirebaseUser user = authResult.user;
    if (user != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("email", user.email);
      final User currentUser = (await getUserFromId(id: user.uid));
      print(currentUser);
      if (!GetIt.I.isRegistered<User>())
        GetIt.I.registerSingleton<User>(currentUser);
      return currentUser;
    }
    return null;
  }

  Future<FirebaseUser> register(String email, String password, String firstName,
      String lastName, String phone) async {
    final AuthResult result = (await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .catchError((error) => print(error)));
    if (result != null) {
      if (result.user != null) {
        User user = new User(
            email: email,
            userId: result.user.uid,
            phone: phone,
            firstName: firstName,
            lastName: lastName);
        await sendEmail(email: email, firstName: firstName, lastName: lastName);
        UserUpdateInfo infos = new UserUpdateInfo();
        infos.displayName = firstName + " " + lastName;
        await result.user.updateProfile(infos);
        await setNewUser(user);
        return result.user;
      }
      return result.user;
    }
    return null;
  }

  Future<void> setNewUser(User user) async {
    await usersCollection.document(user.userId).setData(user.toMap());
  }

  Future<User> getUserFromId({@required String id}) async {
    final DocumentSnapshot documentSnapshot =
        (await usersCollection.document(id).get());
    print(documentSnapshot.data);
    return User.fromMap(documentSnapshot.data);
  }

  Future<void> logout() async {
    GetIt.I.unregister(instance: GetIt.I<User>());
    return _auth.signOut();
  }

  Future<void> updateLocation() async {
    bool request = await Permission.location.isGranted;
    if (!request) {
      await Permission.location.request();
      await getLocation().then((value) => handleLocation(value)).catchError(
          (onError) => Geolocation.enableLocationServices()
              .then((value) => setLocationAgain())
              .catchError((onError) => print(onError.toString())));
    } else {
      await getLocation().then((value) => handleLocation(value)).catchError(
          (onError) => Geolocation.enableLocationServices()
              .then((value) => setLocationAgain())
              .catchError((onError) => print(onError.toString())));
    }
  }

  Future<void> setLocationAgain() async {
    await getLocation().then((value) => handleLocation(value));
  }

  Future<LocationResult> getLocation() async {
    GeolocationResult geolocationResult =
        await Geolocation.requestLocationPermission(
            permission:
                LocationPermission(android: LocationPermissionAndroid.fine));
    if (geolocationResult.isSuccessful) {
      return Geolocation.currentLocation(
        accuracy: LocationAccuracy.best,
        permission: LocationPermission(android: LocationPermissionAndroid.fine),
      ).first;
    }
    return Future(null);
  }

  Future<void> handleLocation(LocationResult result) async {
    if (result != null) {
      double lat = result.location.latitude;
      double long = result.location.longitude;
      String userId = GetIt.I<User>().userId;
      await usersCollection
          .document(userId)
          .updateData({"lat": lat, "long": long});
      GetIt.I<User>().lat = lat;
      GetIt.I<User>().long = long;
    }
  }
  Future<List<Item>> getAll() async {
    QuerySnapshot querySnapshot = await itemsCollection
        .where("completed", isEqualTo: false)
        .where("type", isEqualTo: "Take")
        .orderBy("timestamp", descending: true)
        .getDocuments();

    List<Item> results = new List<Item>();
    querySnapshot.documents
        .forEach((element) => {results.add(Item.fromMap(element.data))});
    return results;
  }

  Future<void> donate(
      {@required String choice, @required String desciption}) async {
    String id = itemsCollection.document().documentID;
    Item item = new Item(
        id: id,
        type: "Donation",
        choice: choice,
        userId: GetIt.I<User>().userId,
        description: desciption,
        timestamp: Timestamp.fromDate(DateTime.now()),
        completed: false);
    return itemsCollection.document(id).setData(item.toMap());
  }

  Future<void> take(
      {@required String choice, @required String desciption}) async {
    String id = itemsCollection.document().documentID;
    Item item = new Item(
        id: id,
        type: "Take",
        choice: choice,
        userId: GetIt.I<User>().userId,
        description: desciption,
        timestamp: Timestamp.fromDate(DateTime.now()),
        completed: false);
    return itemsCollection.document(id).setData(item.toMap());
  }

  //TODO:check user location exists before donate or take

  Future<void> complete(String itemId) async {
    return itemsCollection.document(itemId).updateData({
      "completed": true,
    });
  }

  Future<void> delete(String itemId) async {
    return itemsCollection.document(itemId).delete();
  }

  Future<void> resetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> sendEmail(
      {@required String email,
      @required String firstName,
      @required String lastName}) async {
    String username = "mohamed.mseddi45@gmail.com";
    String password = "lpblbhwayzyxxzgr";

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, "CovidDon")
      ..recipients.add(email) //recipent email
      ..subject = 'CoviDon'
      ..text = 'Welcome ' + firstName + " " + lastName + " to CoviDon.";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }
}
