import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/infrastructure/models/categoryModel.dart';
import 'package:user_app/infrastructure/models/productModel/completeProductModel.dart';
import 'package:user_app/infrastructure/services/productServices.dart';
import 'package:user_app/presentation/elements/appBar.dart';
import 'package:user_app/presentation/elements/divider.dart';
import 'package:user_app/presentation/elements/loading_widget.dart';
import 'package:user_app/presentation/elements/noData.dart';
import 'package:user_app/presentation/elements/productCard.dart';

class GetCategoryBasedProductsView extends StatelessWidget {
  final CategoryModel categoryModel;

  GetCategoryBasedProductsView(this.categoryModel);

  ProductServices _productServices = ProductServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context,
          text: context.locale == Locale('en', 'US')
              ? categoryModel.categoryName
              : categoryModel.categoryNameChinese, onTap: () {
        Navigator.pop(context);
      }),
      body: Column(
        children: [
          CustomDivider(),
          _getUI(context),
        ],
      ),
    );
  }

  Widget _getUI(BuildContext context) {
    return StreamProvider.value(
      value:
          _productServices.streamCategoryBasedProduct(categoryModel.categoryID),
      builder: (context, child) {
        return context.watch<List<CompleteProductModel>>() == null
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
            : context.watch<List<CompleteProductModel>>().length != 0
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        itemCount:
                            context.watch<List<CompleteProductModel>>().length,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                        ),
                        itemBuilder: (BuildContext contxt, int index) {
                          return ProductCard(
                            index: index,
                            productModel: context
                                .read<List<CompleteProductModel>>()[index],
                          );
                        },
                      ),
                    ),
                  )
                : NoData();
      },
    );
  }
}
