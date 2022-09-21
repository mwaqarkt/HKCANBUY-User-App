class CategoryModel {
  String categoryName;
  String categoryImage;
  String categoryNameChinese;
  String categoryImageName;
  String categoryID;
  String userID;

  CategoryModel(
      {this.categoryName,
      this.categoryImage,
      this.categoryImageName,
      this.categoryNameChinese,
      this.userID,
      this.categoryID});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    categoryName = json['categoryName'];
    categoryImage = json['categoryImage'];
    categoryNameChinese = json['categoryNameChinese'];
    categoryID = json['categoryID'];
    categoryImageName = json['categoryImageName'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryName'] = this.categoryName;
    data['categoryImage'] = this.categoryImage;
    data['categoryImageName'] = this.categoryImageName;
    data['categoryNameChinese'] = this.categoryNameChinese;

    data['categoryID'] = docID;
    data['userID'] = this.userID;
    return data;
  }
}
