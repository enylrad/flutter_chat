import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/src/model/auth_request.dart';

class Authentication {
  final _auth = FirebaseAuth.instance;

  Future<AuthenticationRequest> createUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authenticationRequest = AuthenticationRequest();
    try {
      var user = (await _auth.createUserWithEmailAndPassword(
          email: email, password: password))
          .user;
      if(user != null){
        authenticationRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authenticationRequest, e.code);
    }
    return authenticationRequest;
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      return await _auth.currentUser();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<AuthenticationRequest> loginUser(
      {String email = "", String password = ""}) async {
    AuthenticationRequest authenticationRequest = AuthenticationRequest();
    try {
      var user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if(user != null){
        authenticationRequest.success = true;
      }
    } catch (e) {
      _mapErrorMessage(authenticationRequest, e.code);
    }
    return authenticationRequest;
  }

  Future<void> singOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e);
    }
    return null;
  }

  void _mapErrorMessage(
      AuthenticationRequest authenticationRequest, String code) {
    switch (code) {
      case 'ERROR_USER_NOT_FOUND':
        authenticationRequest.errorMessage = "User not found";
        break;
      case 'ERROR_WRONG_PASSWORD':
        authenticationRequest.errorMessage = "Invalid password";
        break;
      case 'ERROR_NETWORK_REQUEST_FAILED':
        authenticationRequest.errorMessage = "Network error";
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        authenticationRequest.errorMessage = "The user is already registered";
        break;
      default:
        authenticationRequest.errorMessage = code;
        break;
    }
  }
}
