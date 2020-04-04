import 'package:charity/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final userscollection=Firestore.instance.collection("users");

class FirebaseService {

  Future<User> login(String email, String password) async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if(user!=null) {
      final User currentUser = (await getUserFromId(user.uid));
      GetIt.I.registerSingleton<User>(currentUser);
      return currentUser;
    }
    return null;
  }

  Future<FirebaseUser> register(
      String email, String password, String name,String phone) async {
    final AuthResult result = (await _auth.createUserWithEmailAndPassword(
        email: email, password: password));
    if(result.user!=null) {
      User user = new User(email: email,userId: result.user.uid,phone: phone,
          name: name);
      UserUpdateInfo infos=new UserUpdateInfo();
      infos.displayName=name;
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
