import 'package:cloud_firestore/cloud_firestore.dart';
import '/infrastructure/models/userModel.dart';

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
      return UserModel.fromJson(value.data() as Map<String,dynamic>);
    });
  }
}
