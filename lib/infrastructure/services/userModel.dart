class UserModel {
  String docID;
  String firstName;
  String lastName;
  String email;
  String contactNumber;
  String type;

  UserModel({
    this.docID,
    this.firstName,
    this.lastName,
    this.email,
    this.type,
    this.contactNumber,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    type = "ADMIN";
    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = docID;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['type'] = this.type;
    data['contactNumber'] = this.contactNumber;
    return data;
  }
}
