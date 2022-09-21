class BannerModel {
  String bannerID;
  String bannerImage;
  String imageUrl;
  String bannerImageName;
  String adminID;

  BannerModel(
      {this.bannerID,
      this.bannerImage,
      this.bannerImageName,
      this.adminID,
      this.imageUrl});

  BannerModel.fromJson(Map<String, dynamic> json) {
    bannerID = json['bannerID'];
    bannerImage = json['bannerImage'];
    bannerImageName = json['bannerImageName'];
    imageUrl = json['imageUrl'];
    adminID = json['adminID'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerID'] = docID;
    data['bannerImage'] = this.bannerImage;
    data['bannerImageName'] = this.bannerImageName;
    data['adminID'] = this.adminID;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
