import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/errorStrings.dart';
import 'package:user_app/application/signUpBusinissLogic.dart';
import 'package:user_app/configurations/enums.dart';

class AuthServices with ChangeNotifier {
  FirebaseAuth _auth;
  User _user;
  Status _status = Status.Uninitialized;
  CollectionReference _db = FirebaseFirestore.instance.collection('ecommUsers');
  AuthServices.instance() : _auth = FirebaseAuth.instance {
    _auth.idTokenChanges().listen(_onAuthStateChanged);
  }

  ///Using Stream to listen to Authentication State
  Stream<User> get authState => _auth.idTokenChanges();

  ///It will use to set the login State
  void setState(Status status) {
    _status = status;
    notifyListeners();
  }

  ///It will give the current user login State
  Status get status => _status;

  ///It will give the current firebase user.
  User get user => _user;
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('ecommUsers');

  ///This will method will authenticate users from Firebase.
  Future<User> signIn(BuildContext context,
      {String email, String password}) async {
    try {
      setState(Status.Authenticating);
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      setState(Status.Authenticated);
      return user.user;
    } on FirebaseAuthException catch (e) {
      setState(Status.Unauthenticated);
      Provider.of<ErrorString>(context, listen: false)
          .saveErrorString(e.message);
      return null;
    }
  }

  ///This method will register user to firebase.
  Future<User> signUp(BuildContext context,
      {String email, String password}) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user.user;
    } on FirebaseAuthException catch (e) {
      Provider.of<ErrorString>(context, listen: false)
          .saveErrorString(e.message);
      Provider.of<SignUpBusinessLogic>(context, listen: false)
          .setState(SignUpStatus.Failed);
      return null;
    }
  }

  ///This method will reset the password.
  Future forgotPassword(BuildContext context, {String email}) async {
    try {
      setState(Status.Authenticating);
      await _auth.sendPasswordResetEmail(email: email);
      setState(Status.Authenticated);
    } on FirebaseAuthException catch (e) {
      Provider.of<ErrorString>(context, listen: false)
          .saveErrorString(e.message);
      Provider.of<SignUpBusinessLogic>(context, listen: false)
          .setState(SignUpStatus.Failed);
      return null;
    }
  }

  ///Use to signOut user from firebase.
  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  ///Constantly check for the users whether he loggedIn or loggedOut
  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
  }
}
