import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'horizontal_sized_box.dart';

class RatingRow extends StatelessWidget {
  final double rating;

  RatingRow(this.rating);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RatingBar.builder(
          initialRating: rating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemSize: 12,
          itemCount: 5,
          updateOnDrag: false,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
          },
        ),
        HorizontalSpace(3),
        Text(
          "(${rating.toStringAsFixed(1)})",
          style: TextStyle(fontSize: 8),
        )
      ],
    );
  }
}
