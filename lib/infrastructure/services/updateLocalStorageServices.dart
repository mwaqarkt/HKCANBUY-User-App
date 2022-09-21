import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/infrastructure/models/userModel.dart';

class UpdateLocalStorageData {
  ///Update Local Storage Data
  Future<UserModel> updateLocalStorageData(String docID, UserModel userModel) {
    print("Incc");
    print(docID);
    return FirebaseFirestore.instance
        .collection("ecommUsers")
        .doc(docID)
        .get()
        .then((value) {
      return UserModel.fromJson(value.data());
    });
  }
}
