import 'package:flutter/cupertino.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetailsModel _userDetails = UserDetailsModel();

  void addUserDetails(UserDetailsModel userDetails) {
    _userDetails = userDetails;
    notifyListeners();
  }

  UserDetailsModel get getUserDetails => _userDetails;
}
