import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

import '/application/notificationHandler.dart';
import '/configurations/backEdnConfigs.dart';
import '/configurations/frontEndConfigs.dart';
import '/infrastructure/models/chatDetailsModel.dart';
import '/infrastructure/models/messagModel.dart';
import '/infrastructure/models/userModel.dart';
import '/infrastructure/services/chat_services.dart';
import '/infrastructure/services/user_services.dart';
import '/presentation/elements/appBar.dart';
import '/presentation/elements/divider.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/loading_widget.dart';

class Messages extends StatefulWidget {
  final String receiverID;
  final String productImage;
  final String productName;
  final String productPrice;
  final String? productID;
  const Messages({
    Key? key,
    required this.receiverID,
    required this.productImage,
    required this.productName,
    required this.productPrice,
     this.productID,
  }) : super(key: key);



  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  ChatServices _services = ChatServices();

  TextEditingController messageController = TextEditingController();

  ScrollController _scrollController = new ScrollController();

  final LocalStorage storage = new LocalStorage(BackEndConfigs.loginLocalDB);

  bool initialized = false;

  UserModel userModel = UserModel();

  UserServices _userServices = UserServices();
  NotificationHandler _notificationHandler = NotificationHandler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: customAppBar(context, text: "Messages", onTap: () {
        Navigator.pop(context);
      }),
      body: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!initialized) {
              var items =
                  storage.getItem(BackEndConfigs.userDetailsLocalStorage);

              if (items != null) {
                userModel = UserModel(
                  docID: items['docID'],
                  firstName: items['firstName'],
                  lastName: items['lastName'],
                );
              }

              initialized = true;
            }
            return snapshot.data == null ? LoadingWidget() : _getUI(context);
          }),
    );
  }

  Widget _getUI(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomDivider(),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 14.0),
          //   child: Container(
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(10),
          //         border: Border.all(color: FrontEndConfigs.buttonColor)),
          //     height: 80,
          //     width: double.infinity,
          //     child: Row(
          //       children: [
          //         ClipRRect(
          //           borderRadius: BorderRadius.only(
          //             topLeft: Radius.circular(10),
          //             bottomLeft: Radius.circular(10),
          //           ),
          //           child: Image.asset(
          //             'assets/images/featureImge.jpg',
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         HorizontalSpace(10),
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Text(
          //                 "This message relates to following product:",
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold, fontSize: 11),
          //               ),
          //               VerticalSpace(5),
          //               Text(
          //                 widget.productName,
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w600, fontSize: 15),
          //               ),
          //               Text(
          //                 "\$ ${widget.productPrice}",
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.w600, fontSize: 14),
          //               ),
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(
              child: StreamProvider.value(
                initialData: [],
                value: _services.streamMessages(
                    myID: userModel.docID!, senderID: widget.receiverID),
                builder: (context, child) {
                  // Timer(
                  //     Duration(milliseconds: 300),
                  //     () => _scrollController.animateTo(
                  //         _scrollController.position.maxScrollExtent,
                  //         duration: Duration(milliseconds: 700),
                  //         curve: Curves.ease));
                  return context.watch<List<MessagesModel>>() == null
                      ? LoadingWidget()
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              context.watch<List<MessagesModel>>().length,
                          itemBuilder: (context, i) {
                            print(userModel.docID);
                            return MessageTile(
                              message: context
                                  .watch<List<MessagesModel>>()[i]
                                  .messageBody!,
                              sendByMe: context
                                      .watch<List<MessagesModel>>()[i]
                                      .fromID ==
                                  userModel.docID,
                              time:
                                  context.watch<List<MessagesModel>>()[i].time,
                            );
                          });
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    style: TextStyle(color: Colors.black, fontSize: 13),
                    controller: messageController,
                    onChanged: (val) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                        hintText: "Type Here...",
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                        ),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () {
                      String message = messageController.text;
                      setState(() {});
                      Future.delayed(Duration(microseconds: 20), () {
                        messageController.clear();
                      });
                      print("Product iD : ${widget.productID}");
                      if (messageController.text.isEmpty) {
                        return;
                      }
                      Timer(
                          Duration(milliseconds: 300),
                          () => _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 700),
                              curve: Curves.ease));
                      _notificationHandler.oneToOneNotificationHelper(
                          docID: "UdPCYhOQgGeLyMNCs7VpDmanRyH3",
                          body: message,
                          title: "You have new message.");
                      _services.addNewMessage(
                          receiverID: widget.receiverID,
                          myID: userModel.docID!,
                          detailsModel: ChatDetailsModel(
                              recentMessage: message,
                              date: DateFormat('MM/dd/yyyy')
                                  .format(DateTime.now()),
                              time:
                                  DateFormat('hh:mm a').format(DateTime.now()),
                              productImage: widget.productImage,
                              productName: widget.productName,
                              productPrice: widget.productPrice),
                          messageModel: MessagesModel(
                              isRead: false,
                              time: DateFormat('MM/dd/yyyy hh:mm a')
                                  .format(DateTime.now()),
                              messageBody: message));
                      _userServices.streamAdmin().first.then((value) {
                        print("Called");
                      });
                    },
                    icon: Icon(
                      Icons.send,
                      color: messageController.text.isEmpty
                          ? Colors.grey
                          : Colors.black,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final time;
  final date;

  MessageTile(
      {required this.message, required this.sendByMe, this.time, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 2,
              bottom: 1,
              left: sendByMe ? 0 : 14,
              right: sendByMe ? 14 : 0),
          alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: 0.6 * MediaQuery.of(context).size.width),
            margin: sendByMe
                ? EdgeInsets.only(left: 30)
                : EdgeInsets.only(right: 30),
            padding: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 10),
            decoration: BoxDecoration(
              color: sendByMe
                  ? FrontEndConfigs.buttonColor.withOpacity(0.6)
                  : FrontEndConfigs.appBaseColor,
              borderRadius: sendByMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(message ?? '',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        height: 1.3,
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300)),
                VerticalSpace(5),
                Text(
                  time,
                  style: TextStyle(fontSize: 9, color: Colors.white60),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
