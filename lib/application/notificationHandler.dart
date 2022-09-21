import 'package:flutter/cupertino.dart';
import 'package:user_app/infrastructure/services/notificationServices.dart';

class NotificationHandler {
  NotificationServices _services = NotificationServices();

  ///Push 1-1 Notification
  oneToOneNotificationHelper(
      {@required String docID, @required String body, @required String title}) {
    _services.streamSpecificUserToken(docID).first.then((value) {
      print("HI HI HI");
      _services.pushOneToOneNotification(
        sendTo: value,
        title: title,
        body: body,
      );
    });
  }
}
