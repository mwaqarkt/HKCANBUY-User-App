class ProductGeneralDetailsModel {
  String? adminID;
  String? productName;
  String? cProductName;
  String? productDescription;
  String? cProductDescription;
  String? unit;
  List? image;
  List? color;
  bool? isActive;
  var rating;
  var productTime;

  ProductGeneralDetailsModel({
    this.productName,
    this.cProductName,
    this.adminID,
    this.productDescription,
    this.cProductDescription,
    this.unit,
    this.image,
    this.isActive,
    this.rating,
    this.color,
    this.productTime,
  });

  ProductGeneralDetailsModel.fromJson(Map<String, dynamic> json) {
    productName = json['productName'];
    cProductName = json['cProductName'];
    productDescription = json['productDescription'];
    cProductDescription = json['cProductDescription'];
    isActive = json['isActive'];
    unit = json['unit'];
    image = json['image'];
    rating = json['rating'];
    color = json['color'];
    adminID = json['adminID'];
    productTime = json['productTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productName'] = this.productName;
    data['cProductName'] = this.cProductName;
    data['rating'] = this.rating;
    data['isActive'] = this.isActive;
    data['productDescription'] = this.productDescription;
    data['cProductDescription'] = this.cProductDescription;
    data['unit'] = this.unit;
    data['image'] = this.image;
    data['userID'] = this.adminID;
    data['color'] = this.color;
    data['productTime'] = DateTime.now();

    return data;
  }
}
