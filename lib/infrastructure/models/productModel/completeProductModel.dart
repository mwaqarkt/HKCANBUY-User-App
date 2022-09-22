import '/infrastructure/models/productModel/productBulkModel.dart';
import '/infrastructure/models/productModel/productDiscountModel.dart';
import '/infrastructure/models/productModel/productFeatureModel.dart';
import '/infrastructure/models/productModel/productGeneralDetailsModel.dart';
import '/infrastructure/models/productModel/sizePriceQuantityModel.dart';

import 'commentReviewModel.dart';

class CompleteProductModel {
  String? docID;
  int? quantity;
  String? price;
  List<dynamic>? categoryID;
  ProductGeneralDetailsModel? productGeneralDetailsModel;
  List<SizePriceQuantityJsonModel>? sizePriceQuantityModel;
  List<ProductFeaturesJsonModel>? selectableFeatures;
  List<ProductFeaturesJsonModel>? productSpecs;
  ProductDiscountModel? discountModel;
  ProductBulkModel? productBulkModel;
  List<CommentReviewModel>? commentReviewModel;

//
  CompleteProductModel(
    this.docID,
      this.categoryID,
    this.productGeneralDetailsModel,
    this.sizePriceQuantityModel,
    this.selectableFeatures,
    this.commentReviewModel,
    this.productSpecs,
    this.discountModel,
    this.productBulkModel,
    this.price,
    this.quantity,
  );

  CompleteProductModel.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    categoryID = json['categoryID'];
    price = json['price'];
    quantity = json['quantity'];
    productGeneralDetailsModel = json['productGeneralDetailsModel'] != null
        ? new ProductGeneralDetailsModel.fromJson(
            json['productGeneralDetailsModel'])
        : null;
    if (json['sizePriceQuantityModel'] != null) {
      sizePriceQuantityModel = [];
      json['sizePriceQuantityModel'].forEach((v) {
        sizePriceQuantityModel!.add(new SizePriceQuantityJsonModel.fromJson(v));
      });
    }
    if (json['commentReviewModel'] != null) {
      commentReviewModel =[];
      json['commentReviewModel'].forEach((v) {
        commentReviewModel!.add(new CommentReviewModel.fromJson(v));
      });
    }
    if (json['selectableFeatures'] != null) {
      selectableFeatures = [];
      json['selectableFeatures'].forEach((v) {
        selectableFeatures!.add(new ProductFeaturesJsonModel.fromJson(v));
      });
    }
    if (json['productSpecs'] != null) {
      productSpecs = [];
      json['productSpecs'].forEach((v) {
        productSpecs!.add(new ProductFeaturesJsonModel.fromJson(v));
      });
    }

    discountModel = json['discountModel'] != null
        ? new ProductDiscountModel.fromJson(json['discountModel'])
        : null;
    productBulkModel = json['productBulkModel'] != null
        ? new ProductBulkModel.fromJson(json['productBulkModel'])
        : null;
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = docID;
    data['quantity'] = quantity;
    data['price'] = price;
    data['categoryID'] = categoryID;
    if (this.productGeneralDetailsModel != null) {
      data['productGeneralDetailsModel'] =
          this.productGeneralDetailsModel!.toJson();
    }
    if (this.sizePriceQuantityModel != null) {
      data['sizePriceQuantityModel'] =
          this.sizePriceQuantityModel!.map((v) => v.toJson()).toList();
    }
    if (this.commentReviewModel != null) {
      data['commentReviewModel'] =
          this.commentReviewModel!.map((v) => v.toJson()).toList();
    }
    if (this.selectableFeatures != null) {
      data['selectableFeatures'] =
          this.selectableFeatures!.map((v) => v.toJson()).toList();
    }
    if (this.productSpecs != null) {
      data['productSpecs'] = this.productSpecs!.map((v) => v.toJson()).toList();
    }
    if (this.discountModel != null) {
      data['discountModel'] = this.discountModel!.toJson();
    }
    if (this.productBulkModel != null) {
      data['productBulkModel'] = this.productBulkModel!.toJson();
    }

    return data;
  }
}
