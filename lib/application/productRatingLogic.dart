import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:user_app/application/app_state.dart';
import 'package:user_app/infrastructure/models/productModel/commentReviewModel.dart';
import 'package:user_app/infrastructure/services/productServices.dart';

class UpdateProductRatingLogic {
  static ProductServices _productServices = ProductServices();

  static updateProductLogic(BuildContext context,
      {String docID,
      var rating,
      String commentText,
      String name,
      String userID}) async {
    _productServices.getSpecificProduct(docID).first.then((event) {
      Provider.of<AppState>(context, listen: false)
          .stateStatus(StateStatus.IsBusy);

      print(rating);
      // int sum = event.ratingModel.fold(0, (p, c) => p + c.rating);
      return _productServices.updateProductRating(
          list: [
            CommentReviewModel(
                userID: userID,
                userName: name,
                rating: rating,
                comment: commentText)
          ],
          docID: docID,
          rating: (event.commentReviewModel.fold(0, (p, c) => p + c.rating) +
                  rating) /
              (event.commentReviewModel.length > 0
                  ? event.commentReviewModel.length + 1
                  : 1)).then((value) => _productServices.addRating(
              list: [
                CommentReviewModel(
                    userID: userID,
                    userName: name,
                    rating: rating,
                    comment: commentText)
              ],
              docID: docID,
              rating: (event.productGeneralDetailsModel.rating + rating) /
                  (event.commentReviewModel.length > 0
                      ? event.commentReviewModel.length + 1
                      : 1)));
    });

    Provider.of<AppState>(context, listen: false)
        .stateStatus(StateStatus.IsFree);
  }
}
