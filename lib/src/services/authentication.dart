import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  Future<FirebaseUser> createUser(
      {String email = "", String password = ""}) async {
    try {
      return (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await _auth.currentUser();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<FirebaseUser> loginUser(
      {String email = "", String password = ""}) async {
    try {
      return (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
    return null;
  }
}
