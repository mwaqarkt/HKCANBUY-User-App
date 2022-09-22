import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '/application/errorStrings.dart';
import '/configurations/backEdnConfigs.dart';
import '/infrastructure/services/authServices.dart';
import '/infrastructure/services/user_services.dart';

class LoginBusinessLogic {
  UserServices _userServices = UserServices();
  final LocalStorage storage = new LocalStorage(BackEndConfigs.loginLocalDB);

  ///This method will authenticate user and do following tasks:
  ///1. Store the details of users in localDB so that we can use these details in app later.
  ///2. Store the details of hod of user's department in localDB so that we can use hod details to send applications.

  Future loginUserLogic(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    var _authServices = Provider.of<AuthServices>(context, listen: false);
    var _error = Provider.of<ErrorString>(context, listen: false);
    var login = Provider.of<AuthServices>(context, listen: false);

    await login
        .signIn(context, email: email, password: password)
        .then((User user) {
      if (user != null) {
        _userServices.streamStudentsData(user.uid).map((user) async {
          await storage.setItem(
              BackEndConfigs.userDetailsLocalStorage, user.toJson(user.docID!));
        }).toList();
      } else {}
    });
  }
}
