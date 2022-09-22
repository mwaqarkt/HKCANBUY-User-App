import 'package:cloud_firestore/cloud_firestore.dart';
import '/infrastructure/models/productModel/commentReviewModel.dart';
import '/infrastructure/models/productModel/completeProductModel.dart';

class ProductServices {
  CollectionReference _productCollection =
      FirebaseFirestore.instance.collection('productsCollection');

  ///Get All Products
  Stream<List<CompleteProductModel>> getAllProducts() {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Get InStock Products
  Stream<List<CompleteProductModel>> getInStockProducts() {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .where('quantity', isGreaterThan: 0)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Get All Products
  Stream<List<CompleteProductModel>> getOutOfStockProducts() {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .where('quantity', isEqualTo: 0)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Get Specific Product
  Stream<CompleteProductModel> getSpecificProduct(String productID) {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .doc(productID)
        .snapshots()
        .map((event) => CompleteProductModel.fromJson(event.data() as Map<String,dynamic>));
  }

  ///Get Popular Products
  Stream<List<CompleteProductModel>> getPopularProducts() {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .orderBy('productGeneralDetailsModel.rating', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Get Popular Products
  Stream<List<CompleteProductModel>> getPriceBasedProducts() {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .orderBy('price', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Get Latest Products
  Stream<List<CompleteProductModel>> getLatestProduct() {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .orderBy('productGeneralDetailsModel.productTime', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Get Category Based Product
  Stream<List<CompleteProductModel>> streamCategoryBasedProduct(
      String categoryID) {
    return FirebaseFirestore.instance
        .collection('productsCollection')
        .where('categoryID', arrayContains: categoryID)
        .snapshots()
        .map((event) => event.docs
            .map((e) => CompleteProductModel.fromJson(e.data()))
            .toList());
  }

  ///Update Product Rating
  Future<void> updateProductRating(
      {required String docID,required  double rating,required  List<CommentReviewModel> list}) async {
    print("Update  Product : $docID");
    return await FirebaseFirestore.instance
        .collection('productsCollection')
        .doc(docID)
        .update({
      'productGeneralDetailsModel.rating': rating,
    });
  }

  ///Update Product Rating
  Future<void> addRating(
      {required String docID,required double rating, required List<CommentReviewModel> list}) async {
    print("Add  Product : $docID");
    return await FirebaseFirestore.instance
        .collection('productsCollection')
        .doc(docID)
        .update({
      'commentReviewModel':
          FieldValue.arrayUnion(list.map((e) => e.toJson()).toList()),
    });
  }
}
