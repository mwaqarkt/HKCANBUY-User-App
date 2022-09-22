class AddressModel {
  String? address;
  String? description;
  String? addressID;
  String? userID;

  AddressModel({this.address, this.userID, this.addressID, this.description});

  AddressModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    addressID = json['addressID'];
    description = json['description'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['addressID'] = docID;
    data['userID'] = this.userID;
    data['description'] = this.description;
    return data;
  }
}
