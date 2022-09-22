class OrderModel {
  String? storeName;
  String? adminID;
  String? storeImage;
  String? productName;
  String? categoryName;
  String? price;
  String? orderID;
  String? userName;
  String? email;
  String? userImage;
  String? location;
  String? quantity;
  String? date;
  String? orderStatus;
  String? userID;
  bool ?isComplete;
  bool ?isCancelled;
  bool ?isPending;
  bool ?isActive;
  String ?totalAmount;
  String ?contactNumber;
  String ?categoryID;
  String ?noteFromAdmin;

  OrderModel(
      {this.storeName,
      this.storeImage,
      this.productName,
      this.categoryName,
      this.adminID,
      this.categoryID,
      this.price,
      this.orderID,
      this.userName,
      this.email,
      this.userImage,
      this.location,
      this.quantity,
      this.date,
      this.orderStatus,
      this.userID,
      this.isComplete,
      this.isCancelled,
      this.isPending,
      this.isActive,
      this.totalAmount,
      this.noteFromAdmin,
      this.contactNumber});

  OrderModel.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    storeImage = json['storeImage'];
    productName = json['productName'];
    categoryName = json['categoryName'];
    price = json['price'];
    orderID = json['orderID'];
    categoryID = json['categoryID'];
    userName = json['userName'];
    email = json['email'];
    userImage = json['userImage'];
    location = json['location'];
    adminID = json['adminID'];
    quantity = json['quantity'];
    date = json['date'];
    orderStatus = json['orderStatus'];
    userID = json['userID'];
    isComplete = json['isComplete'];
    noteFromAdmin = json['noteFromAdmin'];
    isCancelled = json['isCancelled'];
    isPending = json['isPending'];
    isActive = json['isActive'];
    totalAmount = json['totalAmount'];
    contactNumber = json['contactNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeName'] = this.storeName;
    data['storeImage'] = this.storeImage;
    data['productName'] = this.productName;
    data['categoryName'] = this.categoryName;
    data['price'] = this.price;
    data['orderID'] = this.orderID;
    data['adminID'] = this.adminID;
    data['userName'] = this.userName;
    data['categoryID'] = this.categoryID;
    data['email'] = this.email;
    data['userImage'] = this.userImage;
    data['location'] = this.location;
    data['quantity'] = this.quantity;
    data['date'] = this.date;
    data['orderStatus'] = this.orderStatus;
    data['userID'] = this.userID;
    data['noteFromAdmin'] = this.noteFromAdmin;
    data['isComplete'] = this.isComplete;
    data['isCancelled'] = this.isCancelled;
    data['isPending'] = this.isPending;
    data['isActive'] = this.isActive;
    data['totalAmount'] = this.totalAmount;
    data['contactNumber'] = this.contactNumber;
    return data;
  }
}
