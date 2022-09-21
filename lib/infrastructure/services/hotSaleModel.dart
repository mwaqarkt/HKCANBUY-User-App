class HotSaleModel {
  String docID;
  int quantity;

  HotSaleModel({
    this.docID,
    this.quantity,
  });

  HotSaleModel.fromJson(Map<String, dynamic> json) {
    docID = json['docID'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = docID;
    data['quantity'] = this.quantity;
    return data;
  }
}
