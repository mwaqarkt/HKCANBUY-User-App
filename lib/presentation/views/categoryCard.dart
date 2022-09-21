import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:user_app/infrastructure/models/categoryModel.dart';
import 'package:user_app/infrastructure/services/categoryServices.dart';
import 'package:user_app/presentation/elements/dynamicFontSize.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';

class CategoryCard extends StatefulWidget {
  final CategoryModel model;
  final VoidCallback onTap;

  CategoryCard({Key key, this.model, this.onTap}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  CategoryServices _categoryServices = CategoryServices();

  GlobalKey btnKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext ctx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              context.locale != Locale('en', 'US')
                  ? DynamicFontSize(
                      label: widget.model.categoryNameChinese,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )
                  : DynamicFontSize(
                      label: widget.model.categoryName,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
            ],
          ),
          VerticalSpace(10),
          InkWell(
            onTap: () => widget.onTap(),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(9),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                ),
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: widget.model.categoryImage,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => LoadingWidget(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          ),
          // InkWell(
          //   onTap: () => onTap(),
          //   child: Container(
          //     height: 100,
          //     width: MediaQuery.of(context).size.width,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(model.categoryImage),
          //           fit: BoxFit.cover),
          //       borderRadius: BorderRadius.circular(9),
          //     ),
          //   ),
          // ),
          VerticalSpace(10),
          Divider(),
          VerticalSpace(18),
        ],
      ),
    );
  }
}
