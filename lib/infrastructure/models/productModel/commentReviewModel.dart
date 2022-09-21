class CommentReviewModel {
  String userID;
  String userName;
  String comment;
  var rating;

  CommentReviewModel({this.userID, this.userName, this.comment, this.rating});

  CommentReviewModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    userName = json['userName'];
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    return data;
  }
}
