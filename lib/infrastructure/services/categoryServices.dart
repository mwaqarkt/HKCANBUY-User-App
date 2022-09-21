import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/app_state.dart';
import 'package:user_app/infrastructure/models/categoryModel.dart';

class CategoryServices {
  CollectionReference _categoryServices =
      FirebaseFirestore.instance.collection('categoryCollection');

  ///Create Category
  Future<void> createCategory(BuildContext context,
      {CategoryModel model}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('categoryCollection').doc();
    await docRef.set(model.toJson(docRef.id));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Create Category
  Future<void> createChiniesCategory(BuildContext context,
      {CategoryModel model}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('chiniesCategoryCollection')
        .doc();
    await docRef.set(model.toJson(docRef.id));
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Get Category
  Stream<List<CategoryModel>> streamCategory() {
    return _categoryServices.snapshots().map((event) =>
        event.docs.map((e) => CategoryModel.fromJson(e.data())).toList());
  }

  ///Update Category
  Future<void> updateCategory(BuildContext context,
      {String categoryID,
      String categoryName,
      String categoryImage,
      String chCategory}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _categoryServices.doc(categoryID).update({
      'categoryName': categoryName,
      'categoryImage': categoryImage,
      'categoryNameChinese': chCategory
    });
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }

  ///Delete Category
  Future<void> deleteCategory(BuildContext context, {String categoryID}) async {
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsBusy);
    await _categoryServices.doc(categoryID).delete();
    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }
}
