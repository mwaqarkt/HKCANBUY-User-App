class ProductDiscountModel {
  bool? isOnDiscount;
  String? discountPercentage;

  ProductDiscountModel({this.isOnDiscount, this.discountPercentage});

  ProductDiscountModel.fromJson(Map<String, dynamic> json) {
    isOnDiscount = json['isOnDiscount'];
    discountPercentage = json['discountPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOnDiscount'] = this.isOnDiscount;
    data['discountPercentage'] = this.discountPercentage;
    return data;
  }
}
