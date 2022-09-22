class ProductBulkModel {
  bool? offerBulkPurchases;
  String? bulkItems;
  String? bulkPrice;

  ProductBulkModel({this.offerBulkPurchases, this.bulkItems, this.bulkPrice});

  ProductBulkModel.fromJson(Map<String, dynamic> json) {
    offerBulkPurchases = json['offerBulkPurchases'];
    bulkItems = json['bulkItems'];
    bulkPrice = json['bulkPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offerBulkPurchases'] = this.offerBulkPurchases;
    data['bulkItems'] = this.bulkItems;
    data['bulkPrice'] = this.bulkPrice;
    return data;
  }
}
