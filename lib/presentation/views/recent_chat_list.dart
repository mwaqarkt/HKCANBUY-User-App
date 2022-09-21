import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:user_app/infrastructure/models/chatDetailsModel.dart';
import 'package:user_app/infrastructure/models/messagModel.dart';
import 'package:user_app/infrastructure/services/chat_services.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/chat_tile.dart';
import 'package:user_app/presentation/elements/divider.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/elements/noData.dart';
import 'package:user_app/presentation/views/contact_us.dart';
import 'package:user_app/presentation/views/dashboard.dart';

class RecentChatList extends StatefulWidget {
  @override
  _RecentChatListState createState() => _RecentChatListState();
}

class _RecentChatListState extends State<RecentChatList> {
  ChatServices _chatServices = ChatServices();

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      },
      child: Scaffold(
        appBar: customAppBar(context, text: "chat_list", onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard()));
        }),
        body: _getUI(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _chatServices.addNewMessage(
                myID: "4",
                receiverID: user.uid,
                detailsModel: ChatDetailsModel(
                    recentMessage: "Hi how are you?",
                    date: DateFormat('MM/dd/yyyy').format(DateTime.now()),
                    time: DateFormat('hh:mm a').format(DateTime.now()),
                    productImage: "",
                    productName: "Mobile",
                    productPrice: "12"),
                messageModel: MessagesModel(
                    toID: user.uid,
                    fromID: "4",
                    isRead: false,
                    time:
                        DateFormat('MM/dd/yyyy hh:mm a').format(DateTime.now()),
                    messageBody: "Hi how are you?"));
          },
        ),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    var user = Provider.of<User>(context);
    print(user.uid);
    return Column(
      children: [
        CustomDivider(),
        VerticalSpace(5),
        Expanded(
          child: StreamProvider.value(
            value: _chatServices.streamChatList(myID: user.uid),
            builder: (context, child) {
              return context.watch<List<ChatDetailsModel>>() == null
                  ? Container(
                      height: MediaQuery.of(context).size.height - 150,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: LoadingWidget()),
                        ],
                      ),
                    )
                  : context.watch<List<ChatDetailsModel>>().length != 0
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              context.watch<List<ChatDetailsModel>>().length,
                          itemBuilder: (context, i) {
                            return StreamProvider.value(
                              value: _chatServices.getUnreadMessageCounter(
                                  myID: user.uid,
                                  receiverID: context
                                      .watch<List<ChatDetailsModel>>()[i]
                                      .myID),
                              builder: (unReadContext, child) {
                                return context
                                            .watch<List<ChatDetailsModel>>() ==
                                        null
                                    ? LoadingWidget()
                                    : InkWell(
                                        onTap: () {
                                          ChatDetailsModel _model =
                                              context.read<
                                                  List<ChatDetailsModel>>()[i];
                                          setState(() {});
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Messages(
                                                        receiverID:
                                                            _model.otherID,
                                                        productImage:
                                                            _model.productImage,
                                                        productName:
                                                            _model.productName,
                                                        productPrice:
                                                            _model.productPrice,
                                                      )));
                                        },
                                        child: CustomNotificationTile(
                                          image: "assets/images/user.png",
                                          title: context
                                                  .watch<
                                                      List<
                                                          ChatDetailsModel>>()[
                                                      i]
                                                  .myID ??
                                              "",
                                          description: context
                                                  .watch<
                                                      List<
                                                          ChatDetailsModel>>()[
                                                      i]
                                                  .recentMessage ??
                                              "",
                                          time: context
                                                  .watch<
                                                      List<
                                                          ChatDetailsModel>>()[
                                                      i]
                                                  .time
                                                  .toString() ??
                                              "",
                                          counter: unReadContext
                                              .watch<List<MessagesModel>>()
                                              .length,
                                        ),
                                      );
                              },
                            );
                          })
                      : NoData();
            },
          ),
        )
      ],
    );
  }
}
