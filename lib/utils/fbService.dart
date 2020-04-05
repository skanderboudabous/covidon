import 'package:charity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocation/geolocation.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final userscollection = Firestore.instance.collection("users");

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
      final User currentUser = (await getUserFromId(user.uid));
      print(currentUser);
      if (!GetIt.I.isRegistered<User>())
        GetIt.I.registerSingleton<User>(currentUser);
      return currentUser;
    }
    return null;
  }

  Future<FirebaseUser> register(String email, String password, String firstName,
      String lastName, String phone) async {
    final AuthResult result = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password));
    if (result.user != null) {
      User user = new User(
          email: email,
          userId: result.user.uid,
          phone: phone,
          firstName: firstName,
          lastName: lastName);
      UserUpdateInfo infos = new UserUpdateInfo();
      infos.displayName = firstName + " " + lastName;
      await result.user.updateProfile(infos);
      await setNewUser(user);
      return result.user;
    }
    return result.user;
  }

  Future<void> setNewUser(User user) async {
    await userscollection.document(user.userId).setData(user.toMap());
  }

  Future<User> getUserFromId(String id) async {
    final DocumentSnapshot documentSnapshot =
        (await userscollection.document(id).get());
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
              (onError) => Geolocation.enableLocationServices().then((value) =>
              setLocationAgain()).catchError((onError)=>print(onError.toString())));
    } else {
      await getLocation().then((value) => handleLocation(value)).catchError(
          (onError) => Geolocation.enableLocationServices().then((value) =>
              setLocationAgain()).catchError((onError)=>print(onError.toString())));
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
      await userscollection
          .document(userId)
          .updateData({"latitue": lat, "longitude": long});
      GetIt.I<User>().lat = lat;
      GetIt.I<User>().long = long;
    }
  }
}
