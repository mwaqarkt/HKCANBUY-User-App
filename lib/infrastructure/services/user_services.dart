import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '/application/app_state.dart';
import '/configurations/backEdnConfigs.dart';
import '/infrastructure/models/userModel.dart';
import '/infrastructure/services/updateLocalStorageServices.dart';

class UserServices {
  ///Instantiate LocalDB
  final LocalStorage storage = new LocalStorage(BackEndConfigs.loginLocalDB);
  UserModel _bikerModel = UserModel();

  UserModel get bikerModel => _bikerModel;
  UpdateLocalStorageData _data = UpdateLocalStorageData();

  ///Collection Reference of Bikers
  final CollectionReference _ref =
      FirebaseFirestore.instance.collection('ecommUsers');

  ///Add Bikers data to Cloud Firestore
  Future<void> addBikerData(
      User user, UserModel stdModel, BuildContext context) {
    return _ref.doc(user.uid).set(stdModel.toJson(user.uid));
  }

  ///Stream a LoggedIn User
  Stream<UserModel> streamStudentsData(String docID) {
    return _ref
        .doc(docID)
        .snapshots()
        .map((snap) => UserModel.fromJson(snap.data() as Map<String,dynamic>));
  }

  ///Stream a Admin
  Stream<List<UserModel>> streamAdmin() {
    return _ref.where('type', isEqualTo: 'admin').snapshots().map(
        (snap) => snap.docs.map((e) => UserModel.fromJson(e.data() as Map<String,dynamic>)).toList());
  }

  ///Edit LoggedIn Biker Data
  Future<void> editDP(UserModel userModel, String imageUrl) async {
    print(userModel.docID);
    return _ref.doc(userModel.docID).update({
      'image': imageUrl,
    });
  }

  ///Edit LoggedIn Biker Data
  Future<void> editCover(UserModel userModel, String imageUrl) async {
    print(userModel.docID);
    return _ref.doc(userModel.docID).update({
      'cover': imageUrl,
    });
  }

  ///Upload User Profile Pic
  Future uploadFile(BuildContext context,
      {required File image,required UserModel userModel}) async {
    try {
      Provider.of<AppState>(context, listen: false)
          .stateStatus(StateStatus.IsBusy);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('bikerUsersPics/${image.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(image);
      return uploadTask.whenComplete(() async {
        Provider.of<AppState>(context, listen: false)
            .stateStatus(StateStatus.IsFree);
        await storageReference.getDownloadURL().then((fileURL) {
          editDP(userModel, fileURL);
        }).then((value) {
          _data
              .updateLocalStorageData( userModel.docID!, userModel)
              .then((value) async {
            return await storage.setItem(BackEndConfigs.userDetailsLocalStorage,
                value.toJson(userModel.docID!));
          });
        });
      });
    } catch (e) {
      Provider.of<AppState>(context, listen: false)
          .stateStatus(StateStatus.IsError);
    }
  }
}
