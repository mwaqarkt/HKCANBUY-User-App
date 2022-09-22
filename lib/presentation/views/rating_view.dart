import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

import '/application/app_state.dart';
import '/application/productRatingLogic.dart';
import '/presentation/elements/appBar.dart';
import '/presentation/elements/appButton.dart';
import '/presentation/elements/detail_text_field.dart';
import '/presentation/elements/heigh_sized_box.dart';
import '/presentation/elements/navigation_dialog.dart';
import 'homePage.dart';

class RatingView extends StatefulWidget {
  final String productID;
  final String name;
  final String userID;

  RatingView({
    Key? key,
    required this.productID,
    required this.name,
    required this.userID,
  }) : super(key: key);

  @override
  _RatingViewState createState() => _RatingViewState();
}

class _RatingViewState extends State<RatingView> {
  // ProgressDialog? pr;
  TextEditingController _commentController = TextEditingController();

  double rating = 0;

  @override
  Widget build(BuildContext context) {
    print("Product ID : ${widget.productID}");
    // pr = ProgressDialog(context, isDismissible: false);
    return Scaffold(
      appBar: customAppBar(context, text: "Rate our Product", onTap: () {
        Navigator.pop(context);
      }),
      body: _getUI(context),
    );
  }

  Widget _getUI(BuildContext context) {
    var status = Provider.of<AppState>(context);
    return Column(
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemSize: 23,
          itemCount: 5,
          updateOnDrag: true,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (_rating) {
            rating = _rating;
            setState(() {});
          },
        ),
        VerticalSpace(20),
        DetailTextField(
          data: _commentController,
          label: "Write your comment",
          maxLines: 3,
        ),
        AppButton(
          text: "Submit",
          isDark: true,
          onTap: () async {
            // await pr!.show();
            await UpdateProductRatingLogic.updateProductLogic(context,
                docID: widget.productID,
                rating: rating,
                name: widget.name,
                userID: widget.userID,
                commentText: _commentController.text);
            if (status.getStateStatus() == StateStatus.IsFree) {
              showNavigationDialog(context,
                  message: "Thanks for your feedback.",
                  buttonText: "Continue shopping", navigation: () async {
                // await pr!.hide();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              }, secondButtonText: "", showSecondButton: false);
            }
          },
        )
      ],
    );
  }
}
