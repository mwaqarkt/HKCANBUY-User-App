import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '/infrastructure/models/chatDetailsModel.dart';
import '/infrastructure/models/messagModel.dart';

class ChatServices {
  ///Get Recent Chats
  Stream<List<ChatDetailsModel>> streamChatList(
      {required String myID, String? receiverID}) {
    print("MY ID : $myID");
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(myID)
        .collection('recent_chats')
        .snapshots()
        .map((event) => event.docs
            .map((e) => ChatDetailsModel.fromJson(e.data()))
            .toList());
  }

  ///Get Messages
  Stream<List<MessagesModel>> streamMessages({required  String myID,required String senderID}) {
    print("MY ID : $myID");
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(myID)
        .collection('recent_chats')
        .doc(senderID)
        .collection('messages')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => MessagesModel.fromJson(e.data())).toList());
  }

  ///Start New Chat
  Future<void> addNewMessage(
      {required String myID,
      required String receiverID,
      required ChatDetailsModel detailsModel,
      required MessagesModel messageModel}) async {
    return await FirebaseFirestore.instance
        .collection("messages")
        .doc(myID)
        .collection('recent_chats')
        .doc(receiverID)
        .set(detailsModel.toJson(myID: myID, otherID: receiverID))
        .then((value) => FirebaseFirestore.instance
            .collection("messages")
            .doc(myID)
            .collection('recent_chats')
            .doc(receiverID)
            .collection("messages")
            .doc(DateTime.now().toString())
            .set(messageModel.toJson(
                otherID: receiverID,
                fromID: myID,
                docID: DateTime.now().toString())))
        .then((value) => FirebaseFirestore.instance
                .collection("messages")
                .doc(receiverID)
                .collection('recent_chats')
                .doc(myID)
                .set(detailsModel.toJson(myID: receiverID, otherID: myID))
                .then((value) {
              DocumentReference docRef = FirebaseFirestore.instance
                  .collection("messages")
                  .doc(receiverID)
                  .collection('recent_chats')
                  .doc(myID)
                  .collection("messages")
                  .doc(DateTime.now().toString());
              return docRef.set(messageModel.toJson(
                  fromID: myID, otherID: receiverID, docID: docRef.id));
            }));
  }

  ///Get Unread Message Counter
  Stream<List<MessagesModel>> getUnreadMessageCounter(
      {required String myID,required String receiverID}) {
    print("MY ID FROM COUNTER : $receiverID");
    print("MY ID FROM COUNTER : $myID");
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(myID)
        .collection('recent_chats')
        .doc(receiverID)
        .collection('messages')
        .where('isRead', isEqualTo: false)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => MessagesModel.fromJson(e.data())).toList());
  }

  ///Mark Messages as Read
  Future<void> markMessageAsRead(
      {required String myID,required String receiverID,required String messageID}) async {
    print("MY ID : $myID");
    print("Reciever ID : $receiverID");
    print("Message ID : $messageID");
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(myID)
        .collection('recent_chats')
        .doc(receiverID)
        .collection('messages')
        .doc(messageID)
        .update({'isRead': true});
  }
}
