import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/infrastructure/models/bannerModel.dart';

class BannerServices {
  CollectionReference _bannerServices =
      FirebaseFirestore.instance.collection('bannerCollection');

  ///Get Banners
  Stream<List<BannerModel>> streamBanners() {
    return _bannerServices.snapshots().map((event) =>
        event.docs.map((e) => BannerModel.fromJson(e.data())).toList());
  }
}
