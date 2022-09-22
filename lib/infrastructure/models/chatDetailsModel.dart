class ChatDetailsModel {
  String? recentMessage;
  String? myID;
  String? otherID;
  String? time;
  String? date;
  int? sortTime;

  ///Optional Parameters, you can remove these
  String? productImage;
  String? productName;
  String? productPrice;

  ChatDetailsModel({
    this.recentMessage,
    this.myID,
    this.otherID,
    this.time,
    this.productName,
    this.productImage,
    this.productPrice,
    this.sortTime,
    this.date,
  });

  ChatDetailsModel.fromJson(Map<String, dynamic> json) {
    myID = json['myID'];
    otherID = json['otherID'];
    time = json['time'];
    recentMessage = json['recentMessage'];
    productImage = json['productImage'];
    productPrice = json['productPrice'];
    productName = json['productName'];
    date = json['date'];
    sortTime = json['sortTime'];
  }

  Map<String, dynamic> toJson({required String myID,required String otherID}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myID'] = myID;
    data['otherID'] = otherID;
    data['time'] = this.time;
    data['date'] = this.date;
    data['productImage'] = this.productImage;
    data['productPrice'] = this.productPrice;
    data['productName'] = this.productName;
    data['recentMessage'] = this.recentMessage;
    data['sortTime'] = DateTime.now().microsecondsSinceEpoch;
    return data;
  }
}
