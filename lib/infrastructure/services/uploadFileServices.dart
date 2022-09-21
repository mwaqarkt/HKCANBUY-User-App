import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UploadFileServices {
  ///Upload Image to Storage
  Future<String> getUrl(BuildContext context, {File file}) async {
    String postFileUrl;
    try {
      print(file);
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('ecommerceApp/${file.path.split('/').last}');
      UploadTask uploadTask = storageReference.putFile(file);

      await uploadTask.whenComplete(() async {
        await storageReference.getDownloadURL().then((fileURL) {
          postFileUrl = fileURL;
        });
      });
      return postFileUrl;
    } catch (e) {
      rethrow;
    }
  }
}
