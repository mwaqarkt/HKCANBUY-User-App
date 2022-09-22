class AvailableDaysModel {
  String? day;
  String? fromTime;
  String? toTime;
  String? locationID;
  String? docID;

  AvailableDaysModel(
      {this.locationID, this.day, this.fromTime, this.toTime, this.docID});

  AvailableDaysModel.fromJson(Map<String, dynamic> json) {
    locationID = json['locationID'];
    day = json['day'];
    fromTime = json['fromTime'];
    docID = json['docID'];
    toTime = json['toTime'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationID'] = this.locationID;
    data['docID'] = docID;
    data['day'] = this.day;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;

    return data;
  }
}
