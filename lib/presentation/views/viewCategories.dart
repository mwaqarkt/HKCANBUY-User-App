import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/infrastructure/models/categoryModel.dart';
import 'package:user_app/infrastructure/services/categoryServices.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/divider.dart';
import 'package:user_app/presentation/elements/heigh_sized_box.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/elements/noData.dart';
import 'package:user_app/presentation/views/homePage.dart';

import 'categoryCard.dart';
import 'getCategoryBasedProduct.dart';

class ViewCategories extends StatefulWidget {
  @override
  _ViewCategoriesState createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  CategoryServices _categoryServices = CategoryServices();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      },
      child: Scaffold(
        appBar: customAppBar(context, text: "categories", onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }),
        body: _getUI(context),
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return Column(
      children: [
        CustomDivider(),
        VerticalSpace(15),
        Expanded(
          child: StreamProvider.value(
            value: _categoryServices.streamCategory(),
            builder: (context, child) {
              return context.watch<List<CategoryModel>>() == null
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
                  : context.watch<List<CategoryModel>>().length != 0
                      ? ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              context.watch<List<CategoryModel>>().length,
                          itemBuilder: (context, i) {
                            return CategoryCard(
                                onTap: () {
                                  CategoryModel model =
                                      context.read<List<CategoryModel>>()[i];
                                  setState(() {});
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              GetCategoryBasedProductsView(
                                                  model)));
                                },
                                model: context.read<List<CategoryModel>>()[i]);
                          })
                      : NoData();
            },
          ),
        )
      ],
    );
  }
}
