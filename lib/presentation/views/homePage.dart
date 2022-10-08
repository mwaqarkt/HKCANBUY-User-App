import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_3/flutter_swiper_3.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '/application/productList.dart';
import '/infrastructure/models/bannerModel.dart';
import '/infrastructure/models/productModel/completeProductModel.dart';
import '/infrastructure/services/bannerServices.dart';
import '/infrastructure/services/productServices.dart';
import '/presentation/elements/appDrawer.dart';
import '/presentation/elements/divider.dart';
import '/presentation/elements/dynamicFontSize.dart';
import '/presentation/elements/flush_bar.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/loading_widget.dart';
import '/presentation/elements/navigation_dialog.dart';
import '/presentation/elements/noData.dart';
import '/presentation/elements/productCard.dart';
import '/presentation/elements/searchField.dart';
import '/presentation/elements/searchFieldBackArrow.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 0;

  ProductServices _productServices = ProductServices();

  List<CompleteProductModel> searchedProducts = [];

  List<CompleteProductModel> productsList = [];

  bool isSearchingAllow = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> _initFcm() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var uid = FirebaseAuth.instance.currentUser!.uid;
      _firebaseMessaging.getToken().then((token) {
        FirebaseFirestore.instance.collection('deviceTokens').doc(uid).set(
          {
            'deviceTokens': token,
          },
        );
      });
    }
  }

  @override
  void initState() {
    User? user = FirebaseAuth.instance.currentUser;
    _initFcm();
    super.initState();
  }

  Widget _simplePopup(BuildContext context) => Container(
        height: 20,
        child: PopupMenuButton<int>(
          onSelected: (val) {
            if (val == 1) {
              i = 1;
            } else if (val == 2) {
              i = 2;
            } else if (val == 3) {
              i = 3;
            }
            setState(() {});
          },
          padding: EdgeInsets.all(0),
          icon: Icon(
            Icons.filter_list,
            size: 19,
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Text("by_popularity".tr()),
            ),
            PopupMenuItem(
              value: 2,
              child: Text("by_price".tr()),
            ),
            PopupMenuItem(
              value: 3,
              child: Text("latest_product".tr()),
            ),
          ],
        ),
      );

  Stream<List<CompleteProductModel>> _getStream(int i) {
    if (i == 0) {
      return _productServices.getAllProducts();
    } else if (i == 1) {
      return _productServices.getPopularProducts();
    } else if (i == 2) {
      return _productServices.getPriceBasedProducts();
    } else if (i == 3) {
      return _productServices.getLatestProduct();
    } else {
      return _productServices.getAllProducts();
    }
  }

  void _searchProducts(String val) async {
    var productList = Provider.of<ProductProvider>(context, listen: false);
    searchedProducts.clear();
    for (var i in productList.getProducts) {
      var lowerCaseString =
          i.productGeneralDetailsModel!.productName.toString().toLowerCase();

      var defaultCase = i.productGeneralDetailsModel!.productName.toString();

      if (lowerCaseString.contains(val) || defaultCase.contains(val)) {
        searchedProducts.add(i);
      } else {
        setState(() {
          isSearched = true;
        });
      }
    }
    setState(() {});
  }

  bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    final _bannerServices = Provider.of<BannerServices>(context);
    return WillPopScope(
      onWillPop: () async {
        return await showNavigationDialog(context,
            message: "do_you_really_want_to_exit",
            buttonText: "yes", navigation: () {
          exit(0);
        }, secondButtonText: "no", showSecondButton: true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: isSearchingAllow
              ? SearchFieldBackArrow(
                  onTap: () {
                    setState(() {
                      searchedProducts.clear();
                      isSearchingAllow = false;
                      isSearched = false;
                    });
                  },
                )
              : Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      icon: Icon(Icons.menu, size: 28, color: Colors.black),
                    );
                  },
                ),
          centerTitle: true,
          title: !isSearchingAllow
              ? Text(
                  "product".tr(),
                )
              : SearchField(onChanged: (val) {
                  setState(() {
                    _searchProducts(val);
                  });
                }),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 13.0),
              child: !isSearchingAllow
                  ? IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          isSearchingAllow = true;
                        });
                      },
                    )
                  : null,
            ),
            _simplePopup(context)
          ],
        ),
        drawer: AppDrawer(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomDivider(),
            VerticalSpace(20),
            StreamProvider<List<BannerModel>>.value(
              initialData: [],
              value: _bannerServices.streamBanners(),
              builder: (ct, child) {
                return ct.watch<List<BannerModel>>() == null
                    ? LoadingWidget()
                    : Container(
                        height: 170,
                        child: new Swiper(
                          itemBuilder: (BuildContext context, int i) {
                            return InkWell(
                              onTap: () {
                                if (ct.read<List<BannerModel>>()[i].imageUrl ==
                                    "") {
                                  getFlushBar(context,
                                      title:
                                          "URL for this banner not found.".tr(),
                                      icon: Icons.info_outline,
                                      color: Colors.blue);
                                  return;
                                }
                                if (ct.read<List<BannerModel>>()[i].imageUrl !=
                                        null ||
                                    ct.read<List<BannerModel>>()[i].imageUrl !=
                                        "")
                                  _launchURL(ct
                                      .read<List<BannerModel>>()[i]
                                      .imageUrl!);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                height: 270,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(
                                    imageUrl: ct
                                        .watch<List<BannerModel>>()[i]
                                        .bannerImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        LoadingWidget(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                              ),
                            );
                          },
                          autoplay: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: ct.watch<List<BannerModel>>().length,
                          viewportFraction: 0.78,
                          scale: 0.9,
                        ));
              },
            ),
            VerticalSpace(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: DynamicFontSize(
                label: "Our Products",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            VerticalSpace(20),
            _getUI(context),
          ],
        ),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    var productsProvider = Provider.of<ProductProvider>(context, listen: false);
    return StreamProvider<List<CompleteProductModel>>.value(
      initialData: [],
      value: _getStream(i),
      builder: (context, child) {
        if (productsProvider.getProducts.isEmpty)
          Future.delayed(Duration.zero, () {
            productsProvider
                .setProductList(context.watch<List<CompleteProductModel>>());
          });

        return context.watch<List<CompleteProductModel>>() == null
            ? Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(child: LoadingWidget()),
                  ],
                ),
              )
            : context.watch<List<CompleteProductModel>>().length != 0
                ? searchedProducts.isEmpty
                    ? isSearched == true
                        ? NoData()
                        : Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: context
                                    .watch<List<CompleteProductModel>>()
                                    .length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: .9),
                                itemBuilder: (BuildContext context, int index) {
                                  return ProductCard(
                                    index: index,
                                    productModel: context.read<
                                        List<CompleteProductModel>>()[index],
                                  );
                                },
                              ),
                            ),
                          )
                    : GridView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: searchedProducts.length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200, childAspectRatio: 0.95),
                        itemBuilder: (BuildContext context, int i) {
                          return ProductCard(
                              index: i, productModel: searchedProducts[i]);
                        },
                      )
                : NoData();
      },
    );
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
