class CommentReviewModel {
  String userID;
  String userName;
  String comment;
  int  rating;

  CommentReviewModel({
    required this.userID,
    required this.userName,
    required this.comment,
    required this.rating,
  });

  factory CommentReviewModel.fromJson(Map<String, dynamic> json) => CommentReviewModel(
        userID: json['userID'],
        userName: json['userName'],
        comment: json['comment'],
        rating: json['rating']
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['userName'] = this.userName;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    return data;
  }
}
