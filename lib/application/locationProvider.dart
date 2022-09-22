import 'package:flutter/cupertino.dart';
import '/infrastructure/models/orderModel.dart';

class LocationProvider extends ChangeNotifier {
  LocationDetailsModel _location = LocationDetailsModel();

  void setLocation(LocationDetailsModel location) {
    _location = location;
    notifyListeners();
  }

  LocationDetailsModel get getLocation => _location;
}
