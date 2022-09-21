import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/cartBznzLogic.dart';
import 'package:user_app/configurations/frontEndConfigs.dart';
import 'package:user_app/infrastructure/models/adddressModel.dart';
import 'package:user_app/infrastructure/models/orderModel.dart';
import 'package:user_app/infrastructure/models/productModel/completeProductModel.dart';
import 'package:user_app/infrastructure/models/productModel/sizePriceQuantityModel.dart';
import 'package:user_app/infrastructure/services/cartServices.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/appButton.dart';
import 'package:user_app/presentation/elements/dynamicFontSize.dart';
import 'package:user_app/presentation/elements/flush_bar.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/horizontal_sized_box.dart';
import 'package:user_app/presentation/elements/productDescription.dart';
import 'package:user_app/presentation/elements/productTitle.dart';
import 'package:user_app/presentation/elements/ratingRow.dart';
import 'package:user_app/presentation/views/authView/login.dart';

import 'cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  final CompleteProductModel model;

  ProductDetailsScreen(this.model);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<AddressModel> addressName = [];
  String price;
  int sizeIndex;
  CartBusinessLogics _cartBusinessLogics = CartBusinessLogics();
  CartServices _cartServices = CartServices();
  int selectedSize = -1;
  int selectedColor = -1;
  int selectedColorValue = -1;
  SizePriceQuantityJsonModel selectedSizeLabel;
  int _currentValue = 1;
  int selectableFeatureIndex = 0;
  List<SelectedFeatures> selectedFeature = [];

  void setSelectableFeatureIndex(int _i) {
    selectableFeatureIndex = _i;
    setState(() {});
  }

  int get getSelectableFeatureIndex => selectableFeatureIndex;

  setSelectedSize(int i) {
    selectedSize = i;
    setState(() {});
  }

  get getSelectedSize => selectedSize;

  setSelectedSizeLabel(SizePriceQuantityJsonModel label) {
    selectedSizeLabel = label;
    setState(() {});
  }

  SizePriceQuantityJsonModel get getSelectedSizeLabel => selectedSizeLabel;

  setSelectedColor(int i) {
    selectedColor = i;
    setState(() {});
  }

  get getSelectedColor => selectedColor;

  setSelectedColorValue(int i) {
    selectedColorValue = i;
    setState(() {});
  }

  get getSelectedColorValue => selectedColorValue;

  void setSizeIndex(int _sizeIndex) {
    sizeIndex = _sizeIndex;
    setState(() {});
  }

  int get getSizeIndex => sizeIndex;

  void setPrice(String _price) {
    price = _price;
    setState(() {});
  }

  String get getPrice => price;

  @override
  void initState() {
    setPrice(widget.model.price);
    super.initState();
  }

  List<List<int>> listIndex = [];
  List<List<String>> selectedIndex = [];

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return Scaffold(
      appBar: customAppBar(context,
          text: widget.model.productGeneralDetailsModel.productName, onTap: () {
        Navigator.pop(context);
      }),
      body: _getUI(context),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              text: "Add To Cart",
              isDark: true,
              onTap: () {
                if (user == null) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginView()));
                } else {}
                _cartBusinessLogics
                    .checkIfProductAlreadyExists(
                        productID: widget.model.docID, uid: user.uid)
                    .then((value) {
                  if (selectedFeature.isEmpty) {
                    getFlushBar(context,
                        title: "Kindly select product features.",
                        icon: Icons.info,
                        color: Colors.blue);
                    return;
                  }

                  if (selectedSizeLabel == null) {
                    getFlushBar(context,
                        title: "Kindly select product size.",
                        icon: Icons.info,
                        color: Colors.blue);
                    return;
                  }
                  if (value == true) {
                    getFlushBar(context,
                        title: "Product is already in cart.",
                        icon: Icons.info,
                        color: Colors.blue);
                  } else {
                    print("getSelectedColor : $getSelectedColorValue");
                    _cartServices
                        .addToCart(context,
                            uid: user.uid,
                            model: CartList(
                                productDetails: ProductDetails(
                                    productName: widget.model
                                        .productGeneralDetailsModel.productName,
                                    featuresList: selectedFeature,
                                    quantity: _currentValue,
                                    productImage: widget.model
                                        .productGeneralDetailsModel.image[0],
                                    size: getSelectedSizeLabel.label,
                                    sizeID: getSelectedSizeLabel.label,
                                    docID: widget.model.docID,
                                    color: getSelectedColorValue,
                                    perQuantityPrice:
                                        getSelectedSizeLabel.value,
                                    totalPrice: _currentValue *
                                        int.parse(getSelectedSizeLabel.value)),
                                quantity: _currentValue,
                                totalPrice: int.parse(widget.model.price)))
                        .then((value) {
                      return Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartView()));
                    });
                  }
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: [
              ...widget.model.productGeneralDetailsModel.image
                  .map((e) => Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          e,
                          fit: BoxFit.cover,
                        ),
                      ))
                  .toList(),
              Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.model.productGeneralDetailsModel.image[0],
                  fit: BoxFit.cover,
                ),
              )
            ],
            options: CarouselOptions(
                autoPlay: true,
                autoPlayCurve: Curves.easeInOut,
                enlargeCenterPage: false,
                viewportFraction: 1,
                aspectRatio: 1.5,
                enableInfiniteScroll: false),
          ),
          VerticalSpace(10),
          ProductTitle(widget.model.productGeneralDetailsModel.productName),
          VerticalSpace(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RatingRow(
                    widget.model.productGeneralDetailsModel.rating.toDouble()),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (!widget.model.discountModel.isOnDiscount)
                      Text(
                        getPrice == null
                            ? "\$${double.parse(widget.model.price).toStringAsFixed(1)}"
                            : "\$${double.parse(getPrice).toStringAsFixed(1)}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 21),
                      ),
                    if (widget.model.discountModel.isOnDiscount)
                      Text(
                        getPrice == null
                            ? "\$${double.parse(widget.model.price).toStringAsFixed(1)}"
                            : "\$${double.parse(getPrice).toStringAsFixed(1)}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 21),
                      ),
                    HorizontalSpace(5),
                    if (widget.model.discountModel.isOnDiscount)
                      Text(
                        getPrice == null
                            ? "\$${(int.parse(widget.model.discountModel.discountPercentage) * (int.parse(widget.model.sizePriceQuantityModel[0].value) / 100)).toStringAsFixed(1)}"
                            : "\$${(int.parse(widget.model.discountModel.discountPercentage) * (int.parse(getPrice) / 100)).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
          VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DynamicFontSize(
              label: "Available Sizes",
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          VerticalSpace(6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 50,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.model.sizePriceQuantityModel.length,
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          setSelectedSizeLabel(
                              widget.model.sizePriceQuantityModel[i]);
                          setSizeIndex(i);
                          setPrice(
                              widget.model.sizePriceQuantityModel[i].value);
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: getSizeIndex == i
                                  ? FrontEndConfigs.buttonColor
                                  : Colors.transparent,
                              border: Border.all(
                                  color: FrontEndConfigs.buttonColor),
                              shape: BoxShape.circle),
                          child: Center(
                            child: DynamicFontSize(
                              label: widget
                                  .model.sizePriceQuantityModel[i].label
                                  .toString()
                                  .toUpperCase(),
                              fontSize: 10,
                              color: getSizeIndex == i
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DynamicFontSize(
              label: "Selectable Features",
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          VerticalSpace(6),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.model.selectableFeatures.length,
              itemBuilder: (context, i) {
                if (listIndex.length <=
                    widget.model.selectableFeatures.length) {
                  listIndex.add([]);
                  selectedIndex.add([]);
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.model.selectableFeatures[i].label,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      VerticalSpace(6),
                      Container(
                        height: 80,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                widget.model.selectableFeatures[i].value.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if (listIndex[i].length <=
                                  widget.model.selectableFeatures[i].value
                                      .length) {
                                listIndex[i].add(i);
                              }
                              return Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    child: InkWell(
                                      onTap: () {
                                        setSelectableFeatureIndex(index);
                                        if (!selectedIndex[i].contains(widget
                                            .model
                                            .selectableFeatures[i]
                                            .value[index])) {
                                          selectedIndex[i].clear();
                                          selectedIndex[i].add(widget
                                              .model
                                              .selectableFeatures[i]
                                              .value[index]);
                                          selectedFeature.add(SelectedFeatures(
                                              label: widget.model
                                                  .selectableFeatures[i].label,
                                              value: widget
                                                  .model
                                                  .selectableFeatures[i]
                                                  .value[index]));

                                          setState(() {});
                                        }

                                        // if (selectedIndex[i].isNotEmpty) {

                                        // }
                                        print(selectedIndex[i]);
                                        // if (selectedIndex[i].contains(
                                        //     getSelectableFeatureIndex)) {
                                        //   selectedIndex[i].remove(
                                        //       getSelectableFeatureIndex);
                                        // } else {
                                        //   selectedIndex[i]
                                        //       .add(selectedIndex[i][index]);
                                        // }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          // color: Colors.blue
                                          color: selectedIndex[i].contains(
                                                  widget
                                                      .model
                                                      .selectableFeatures[i]
                                                      .value[index])
                                              ? FrontEndConfigs.buttonColor
                                              : Colors.grey,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.0, vertical: 3),
                                          child: Text(
                                            widget.model.selectableFeatures[i]
                                                .value[index],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                      Divider(),
                      VerticalSpace(5),
                    ],
                  ),
                );
              }),
          VerticalSpace(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DynamicFontSize(
                label: "Select Quantity : ",
              ),
              Container(
                child: NumberPicker(
                  itemHeight: 40,
                  value: _currentValue,
                  minValue: 1,
                  maxValue: 100,
                  onChanged: (value) => setState(() => _currentValue = value),
                ),
              ),
            ],
          ),
          VerticalSpace(20),
          if (widget.model.productGeneralDetailsModel.color.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DynamicFontSize(
                label: "Available Colors",
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          if (widget.model.productGeneralDetailsModel.color.isNotEmpty)
            VerticalSpace(15),
          if (widget.model.productGeneralDetailsModel.color.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  ...widget.model.productGeneralDetailsModel.color.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: InkWell(
                        onTap: () {
                          setSelectedColorValue(e);
                          setSelectedColor(widget
                              .model.productGeneralDetailsModel.color
                              .indexOf(e));
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          child: getSelectedColor ==
                                  widget.model.productGeneralDetailsModel.color
                                      .indexOf(e)
                              ? Center(
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(
                                  height: 1,
                                  width: 1,
                                ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(e)),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          VerticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: DynamicFontSize(
              label: "Description",
              fontSize: 17,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          VerticalSpace(10),
          ProductDescription(
              widget.model.productGeneralDetailsModel.productDescription),
          VerticalSpace(15),
          if (widget.model.productBulkModel.offerBulkPurchases)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: DynamicFontSize(
                    label: "stock_purchases",
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
                VerticalSpace(10),
                if (widget.model.productBulkModel.offerBulkPurchases)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        DynamicFontSize(label: "stock_items", fontSize: 15),
                        HorizontalSpace(10),
                        DynamicFontSize(
                            label: widget.model.productBulkModel.bulkItems,
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ],
                    ),
                  ),
                if (widget.model.productBulkModel.offerBulkPurchases)
                  VerticalSpace(10),
                if (widget.model.productBulkModel.offerBulkPurchases)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        DynamicFontSize(label: "stock_price", fontSize: 15),
                        HorizontalSpace(10),
                        DynamicFontSize(
                            label:
                                "\$" + widget.model.productBulkModel.bulkPrice,
                            fontWeight: FontWeight.w500,
                            fontSize: 13),
                      ],
                    ),
                  ),
              ],
            ),
          VerticalSpace(20),
          if (widget.model.commentReviewModel.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DynamicFontSize(
                label: "Comments and Reviews",
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          if (widget.model.commentReviewModel.isNotEmpty) VerticalSpace(10),
          if (widget.model.commentReviewModel.isNotEmpty)
            ...widget.model.commentReviewModel
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20,
                                      child: Text(widget
                                          .model
                                          .commentReviewModel[widget
                                              .model.commentReviewModel
                                              .indexOf(e)]
                                          .userName
                                          .substring(0, 1)),
                                    ),
                                    HorizontalSpace(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          DynamicFontSize(
                                              label: widget
                                                  .model
                                                  .commentReviewModel[widget
                                                      .model.commentReviewModel
                                                      .indexOf(e)]
                                                  .userName,
                                              fontSize: 13),
                                          VerticalSpace(4),
                                          DynamicFontSize(
                                            isAlignCenter: false,
                                            label: widget
                                                .model
                                                .commentReviewModel[widget
                                                    .model.commentReviewModel
                                                    .indexOf(e)]
                                                .comment,
                                            fontSize: 11,
                                            color: Colors.black54,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              RatingRow(double.parse(widget
                                  .model
                                  .commentReviewModel[widget
                                      .model.commentReviewModel
                                      .indexOf(e)]
                                  .rating
                                  .toString()))
                            ],
                          ),
                          Divider(),
                          VerticalSpace(10),
                        ],
                      ),
                    ))
                .toList(),
        ],
      ),
    );
  }
}
