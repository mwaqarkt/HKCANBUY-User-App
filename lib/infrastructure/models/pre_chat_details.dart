class PreChatDetailsModel {
  String myID;
  String chatID;

  PreChatDetailsModel({
    this.myID,
    this.chatID,
  });

  PreChatDetailsModel.fromJson(Map<String, dynamic> json) {
    myID = json['myID'];
    chatID = json['chatID'];
  }

  Map<String, dynamic> toJson({String myID, String otherID}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myID'] = myID;
    data['chatID'] = otherID;
    return data;
  }
}
