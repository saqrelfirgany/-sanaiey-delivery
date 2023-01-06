
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleGuaranteeItem extends StatelessWidget {
  final String imagePath;
  final String titleText;
  final String descriptionText;

  SingleGuaranteeItem({this.imagePath :"", this.titleText :"", this.descriptionText :""});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: isLandscape(context) ? .5 * width * .2 : width * .2,
            height: isLandscape(context) ? 2 * height * .04 : height * .04,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(imagePath))),
          ),
          Column(
            children: [
              Container(
                width: width * .68,
                child: CustomText(
                  fontWeight: FontWeight.bold,
                  textColor: blackColor,
                  text: titleText,
                  textAlign: TextAlign.start,
                ),
              ),
              CustomSizedBox(
                percentageOfHeight: .005,
              ),
              Container(
                width: width * .68,
                child: CustomText(
                  textColor: blackColor,
                  textAlign: TextAlign.start,
                  text: descriptionText,
                  percentageOfHeight: .015,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
