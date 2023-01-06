
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleMainCategoryCard extends StatelessWidget {
  final String imagePath;
  final String categoryName;
  final VoidCallback ?  onTapCategoryCard;

  SingleMainCategoryCard(
      {this.imagePath :"", this.categoryName :"", this.onTapCategoryCard});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTapCategoryCard,
      child: Neumorphic(
          child: Container(
        color: whiteColor,
        width: width * .44,
        height: isLandscape(context) ? 2 * height * 0.16 : height * 0.16,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * .2,
                height:
                    isLandscape(context) ? 2 * height * 0.08 : height * 0.08,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imagePath))),
              ),
              CustomSizedBox(),
              CustomText(
                text: categoryName,
                textColor: blackColor,
                fontWeight: FontWeight.bold,
              )
            ],
          ),
        ),
      )),
    );
  }
}
