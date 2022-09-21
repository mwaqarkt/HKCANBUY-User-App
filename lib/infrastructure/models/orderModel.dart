class OrderDetailsModel {
  bool isCancelled;
  String orderID;
  bool isReady;
  bool isPending;
  bool isActive;
  UserDetailsModel userDetailsModel;
  String completedDate;
  String processedDate;
  String uid;
  String placementDate;
  NoteFromUserModel noteFromUserModel;
  String pickupDate;
  LocationDetailsModel locationDetailsModel;
  String cancelledDate;
  String noteFromAdmin;
  List<CartList> cartList;
  bool isComplete;
  int totalPrice;

  OrderDetailsModel(
      {this.isCancelled,
      this.orderID,
      this.isReady,
      this.isPending,
      this.isActive,
      this.userDetailsModel,
      this.completedDate,
      this.processedDate,
      this.uid,
      this.placementDate,
      this.noteFromUserModel,
      this.pickupDate,
      this.locationDetailsModel,
      this.cancelledDate,
      this.cartList,
      this.noteFromAdmin,
      this.totalPrice,
      this.isComplete});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    isCancelled = json['isCancelled'];
    noteFromAdmin = json['noteFromAdmin'];
    orderID = json['orderID'];
    isReady = json['isReady'];
    isPending = json['isPending'];
    isActive = json['isActive'];
    userDetailsModel = json['userDetailsModel'] != null
        ? new UserDetailsModel.fromJson(json['userDetailsModel'])
        : null;
    completedDate = json['completedDate'];
    processedDate = json['processedDate'];
    uid = json['uid'];
    placementDate = json['placementDate'];
    noteFromUserModel = json['noteFromUserModel'] != null
        ? new NoteFromUserModel.fromJson(json['noteFromUserModel'])
        : null;
    pickupDate = json['pickupDate'];
    locationDetailsModel = json['locationDetailsModel'] != null
        ? new LocationDetailsModel.fromJson(json['locationDetailsModel'])
        : null;
    cancelledDate = json['cancelledDate'];
    if (json['cartList'] != null) {
      cartList = new List<CartList>();
      json['cartList'].forEach((v) {
        cartList.add(new CartList.fromJson(v));
      });
    }
    isComplete = json['isComplete'];
    totalPrice = json['totalPrice'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isCancelled'] = false;
    data['orderID'] = docID;
    data['isReady'] = false;
    data['isPending'] = true;
    data['isActive'] = false;
    if (this.userDetailsModel != null) {
      data['userDetailsModel'] = this.userDetailsModel.toJson();
    }
    data['completedDate'] = "";
    data['processedDate'] = "";
    data['uid'] = this.uid;
    data['placementDate'] = DateTime.now().toString();
    if (this.noteFromUserModel != null) {
      data['noteFromUserModel'] = this.noteFromUserModel.toJson();
    }
    data['pickupDate'] = "";
    if (this.locationDetailsModel != null) {
      data['locationDetailsModel'] = this.locationDetailsModel.toJson();
    }
    data['cancelledDate'] = "";
    if (this.cartList != null) {
      data['cartList'] = this.cartList.map((v) => v.toJson(v.docID)).toList();
    }
    data['isComplete'] = false;
    data['totalPrice'] = this.totalPrice;
    data['noteFromAdmin'] = "";
    return data;
  }
}

class UserDetailsModel {
  String uid;
  String lastName;
  String firstName;
  String contactNumber;
  String email;

  UserDetailsModel(
      {this.uid,
      this.lastName,
      this.firstName,
      this.contactNumber,
      this.email});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    lastName = json['lastName'];
    firstName = json['firstName'];
    contactNumber = json['contactNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['lastName'] = this.lastName;
    data['firstName'] = this.firstName;
    data['contactNumber'] = this.contactNumber;
    data['email'] = this.email;
    return data;
  }
}

class NoteFromUserModel {
  String comment;
  String id;

  NoteFromUserModel({this.comment, this.id});

  NoteFromUserModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['id'] = this.id;
    return data;
  }
}

class LocationDetailsModel {
  String selectedPickUpDay;
  String pickupLocation;
  String selectedPickUpTime;

  LocationDetailsModel(
      {this.selectedPickUpDay, this.pickupLocation, this.selectedPickUpTime});

  LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    selectedPickUpDay = json['selectedPickUpDay'];
    pickupLocation = json['pickupLocation'];
    selectedPickUpTime = json['selectedPickUpTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selectedPickUpDay'] = this.selectedPickUpDay;
    data['pickupLocation'] = this.pickupLocation;
    data['selectedPickUpTime'] = this.selectedPickUpTime;
    return data;
  }
}

class CartList {
  String uid;
  int quantity;
  int totalPrice;
  int sortTime;
  String docID;
  ProductDetails productDetails;

  CartList({
    this.quantity,
    this.totalPrice,
    this.sortTime,
    this.docID,
    this.uid,
    this.productDetails,
  });

  CartList.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    totalPrice = json['totalPrice'];
    sortTime = json['sortTime'];
    docID = json['docID'];
    uid = json['uid'];
    productDetails = json['productDetails'] != null
        ? new ProductDetails.fromJson(json['productDetails'])
        : null;
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quantity'] = this.quantity;
    data['totalPrice'] = this.totalPrice;
    data['sortTime'] = this.sortTime;
    data['uid'] = this.uid;
    data['docID'] = docID;
    if (this.productDetails != null) {
      data['productDetails'] = this.productDetails.toJson();
    }

    return data;
  }
}

class SelectedFeatures {
  String value;
  String label;

  SelectedFeatures({
    this.value,
    this.label,
  });

  SelectedFeatures.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['label'] = this.label;

    return data;
  }
}

class ProductDetails {
  String sizeID;
  String productImage;
  int quantity;
  int color;
  String size;
  int totalPrice;
  String docID;
  String perQuantityPrice;
  String productName;
  List<SelectedFeatures> featuresList;

  ProductDetails(
      {this.sizeID,
      this.productImage,
      this.quantity,
      this.color,
      this.size,
      this.totalPrice,
      this.featuresList,
      this.docID,
      this.perQuantityPrice,
      this.productName});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    sizeID = json['sizeID'];
    productImage = json['productImage'];
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    totalPrice = json['totalPrice'];
    docID = json['docID'];
    perQuantityPrice = json['perQuantityPrice'];
    productName = json['productName'];
    if (json['featuresList'] != null) {
      featuresList = new List<SelectedFeatures>();
      json['featuresList'].forEach((v) {
        featuresList.add(new SelectedFeatures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sizeID'] = this.sizeID;
    data['productImage'] = this.productImage;
    data['quantity'] = this.quantity;
    data['color'] = this.color;
    data['size'] = this.size;
    data['totalPrice'] = this.totalPrice;
    data['docID'] = this.docID;
    data['perQuantityPrice'] = this.perQuantityPrice;
    data['productName'] = this.productName;

    if (this.featuresList != null) {
      data['featuresList'] = this.featuresList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
