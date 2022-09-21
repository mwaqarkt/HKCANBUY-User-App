import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/infrastructure/models/availableDayModel.dart';

class AddAvailableDaysServices {
  CollectionReference _availableDaysCollection =
      FirebaseFirestore.instance.collection('availableDays');

  ///Get Time Slots
  Stream<List<AvailableDaysModel>> streamTimeSlots(String locationID) {
    return _availableDaysCollection
        .where('locationID', isEqualTo: locationID)
        .orderBy('day')
        .snapshots()
        .map((event) => event.docs
            .map((e) => AvailableDaysModel.fromJson(e.data()))
            .toList());
  }

  ///Get Time Slots
  Stream<List<AvailableDaysModel>> streamLocationAndDayBasedTimeSlot(
      String locationID, String dayID) {
    print("Called");
    print(locationID);
    print(dayID);
    return _availableDaysCollection
        .where('locationID', isEqualTo: locationID)
        .where('day', isEqualTo: dayID)
        .snapshots()
        .map((event) => event.docs
            .map((e) => AvailableDaysModel.fromJson(e.data()))
            .toList());
  }
}
