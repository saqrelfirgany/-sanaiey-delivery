
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/widgets/single_fav_produuct_card.dart';
import 'package:sanaiey/utils/responsive.dart';

class SimilarProductsPart extends StatelessWidget {
  const SimilarProductsPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                    right: width(context) * .05, left: width(context) * .05),
                // ignore: prefer_const_constructors
                child: CustomText(
                  text: "منتجات مشابهة",
                  textColor: blackColor,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(
                    right: width(context) * .05, left: width(context) * .05),
                child: Container(
                  height: 1,
                  width: width(context) * .3,
                  color: blackColor,
                )),
          ],
        ),
        // ignore: sized_box_for_whitespace
        Container(
            height: isLandscape(context)
                ? 2 * height(context) * .28
                : height(context) * .28,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const SingleFavoriteProductCard(imagePath: "");
                })),
      ],
    );
  }
}
