import 'package:charity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userscollection=Firestore.instance.collection("users");

class FirebaseService {

  Future<User> login(String email, String password) async {
    final authResult= (await _auth.signInWithEmailAndPassword(
            email: email, password: password).catchError((error)=>print
      (error.toString())));
    if(authResult==null)
      return null;
    FirebaseUser user=authResult.user;
    if(user!=null) {
      SharedPreferences prefs= await SharedPreferences.getInstance();
      prefs.setString("email", user.email);
      final User currentUser = (await getUserFromId(user.uid));
      GetIt.I.registerSingleton<User>(currentUser);
      return currentUser;
    }
    return null;
  }

  Future<FirebaseUser> register(
      String email, String password, String firstName,String lastName,String
  phone)
  async {
    final AuthResult result = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password));
    if(result.user!=null) {
      User user = new User(email: email,userId: result.user.uid,phone: phone,
          firstName: firstName,lastName: lastName);
      UserUpdateInfo infos=new UserUpdateInfo();
      infos.displayName=firstName+" "+lastName;
      await result.user.updateProfile(infos);
      await setNewUser(user);
      return result.user;
    }
    return result.user;
  }

  Future<void> setNewUser(User user) async{
    await userscollection.document(user.userId).setData(user
        .toMap());
  }

  Future<User> getUserFromId(String id) async {
    final DocumentSnapshot documentSnapshot =
        (await userscollection.document(id).get());
    return User.fromMap(documentSnapshot.data);

  }
  Future<void> logout()async{
    return _auth.signOut();
  }
}
