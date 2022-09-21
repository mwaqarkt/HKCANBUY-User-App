class NoteFromUser {
  String id;
  String comment;

  NoteFromUser({this.id, this.comment});

  NoteFromUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson(String docID) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = docID;
    data['comment'] = this.comment;
    return data;
  }
}
