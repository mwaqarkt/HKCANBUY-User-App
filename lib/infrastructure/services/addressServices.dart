import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/infrastructure/models/adddressModel.dart';

class AddressServices {
  CollectionReference _addressServices =
      FirebaseFirestore.instance.collection('addressLocation');

  ///Get Address
  Stream<List<AddressModel>> streamAddress() {
    return _addressServices.snapshots().map((event) =>
        event.docs.map((e) => AddressModel.fromJson(e.data())).toList());
  }

  ///Get Specific Address
  Stream<List<AddressModel>> streamSpecificAddress(String id) {
    return _addressServices.where('addressID', isEqualTo: id).snapshots().map(
        (event) =>
            event.docs.map((e) => AddressModel.fromJson(e.data())).toList());
  }
}
