import 'package:Anwar/data/model/response/review_model.dart';
import 'package:Anwar/localization/language_constrants.dart';
import 'package:Anwar/utill/custom_themes.dart';
import 'package:Anwar/utill/dimensions.dart';
import 'package:Anwar/view/basewidget/custom_app_bar.dart';
import 'package:Anwar/view/screen/product/widget/review_widget.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatelessWidget {
  final List<ReviewModel> reviewList;
  ReviewScreen({this.reviewList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomAppBar(title: getTranslated('reviews', context)),
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          child: Text(
              getTranslated('reviews', context) + '(${reviewList.length})',
              style: robotoBold),
        ),
        Expanded(
            child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
          itemCount: reviewList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
              color: Theme.of(context).accentColor,
              child: ReviewWidget(reviewModel: reviewList[index]),
            );
          },
        )),
      ]),
    );
  }
}
