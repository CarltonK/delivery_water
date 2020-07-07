import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:water_del/models/userModel.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  final Firestore db = Firestore.instance;
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseUser currentUser;
  Status _status = Status.Uninitialized;

  AuthProvider.instance() : auth = FirebaseAuth.instance {
    auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => currentUser;

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      currentUser = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  /*
  USER REGISTRATION
  */
  Future createUserEmailPass(UserModel user) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);

      currentUser = result.user;

      //Get the uid
      String uid = currentUser.uid;

      // //Log an Analytics Event signalling SIGN UP
      // await funnel.logSignUp(uid);

      currentUser.sendEmailVerification();

      //print('Positive Registration Response: ${currentUser.uid}');
      //Try adding the user to the Firestore
      await saveUser(user, uid);
      return Future.value(currentUser);
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      var response;
      if (e.toString().contains("ERROR_WEAK_PASSWORD")) {
        response = 'Your password is weak. Please choose another';
      }
      if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        response = 'The email format entered is invalid';
      }
      if (e.toString().contains("ERROR_EMAIL_ALREADY_IN_USE")) {
        response = 'An account with the same email exists';
      }
      return response;
    }
  }

  Future saveUser(UserModel user, String uid) async {
    //Remove password from user class and replace with null
    user.password = null;
    //Set uid to user model
    user.uid = uid;
    try {
      await db.collection("users").document(uid).setData(user.toFirestore());
    } catch (e) {
      print("saveUser ERROR -> ${e.toString()}");
    }
  }

  /*
  USER LOGIN
  */
  Future signInEmailPass(UserModel user) async {
    _status = Status.Authenticating;
    notifyListeners();
    try {
      AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      currentUser = result.user;

      //Check if email is verified before proceeding
      bool emailVerificationStatus = currentUser.isEmailVerified;

      if (emailVerificationStatus) {
        return Future.value(currentUser);
      } else {
        return 'Please verify your email. We sent you an email earlier';
      }
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      var response;
      if (e.toString().contains("ERROR_WRONG_PASSWORD")) {
        response = 'Invalid credentials. Please try again';
      }
      if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        response = 'The email format entered is invalid';
      }
      if (e.toString().contains("ERROR_USER_NOT_FOUND")) {
        response = 'Please register first';
      }
      if (e.toString().contains("ERROR_USER_DISABLED")) {
        response = 'Your account has been disabled';
      }
      if (e.toString().contains("ERROR_TOO_MANY_REQUESTS")) {
        response = 'Too many requests. Please try again in 2 minutes';
      }
      return response;
    }
  }

  /*
  USER PASSWORD RESET
  */
  Future resetPass(UserModel user) async {
    var response;
    try {
      await auth.sendPasswordResetEmail(email: user.email);
      // await funnel.logEvent('Password Reset', user.email);
      response = true;
      return response;
    } catch (e) {
      if (e.toString().contains("ERROR_INVALID_EMAIL")) {
        response = 'Invalid Email. Please enter the correct email';
        //print('Negative Response: $response');
      }
      if (e.toString().contains("ERROR_USER_NOT_FOUND")) {
        response = 'Please register first';
        //print('Negative Response: $response');
      }
      return response;
    }
  }

  /*
  USER LOGOUT
  */
  Future<void> logout() async {
    auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Stream<UserModel> getUserDoc(FirebaseUser user) {
    return db
        .collection('users')
        .document(user.uid)
        .snapshots()
        .map((doc) => UserModel.fromFirestore(doc));
  }

  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      final AuthResult authResult = await auth.signInWithCredential(credential);
      final FirebaseUser user = authResult.user;

      UserModel model = new UserModel(email: user.email, password: null);

      await saveUser(model, user.uid);

      return user;
    } catch (e) {
      print('signInWithGoogle ERROR -> ${e.toString()}');
      return null;
    }
  }
}
