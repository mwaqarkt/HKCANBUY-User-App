class RatingModel {
  String? docID;
  var rating;
  String? commentText;

  RatingModel({this.rating, this.docID, this.commentText});

  RatingModel.fromJson(Map<String, dynamic> json) {
    print("HI JSON");
    docID = json['docID'];
    commentText = json['commentText'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docID'] = docID;
    data['rating'] = this.rating;
    data['commentText'] = this.commentText;

    return data;
  }
}
