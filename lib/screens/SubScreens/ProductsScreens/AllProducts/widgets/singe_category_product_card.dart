
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleCategoryProductCard extends StatelessWidget {
  const SingleCategoryProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          child: const Center(
            child: Icon(Icons.lightbulb_outline),
          ),
          margin: EdgeInsets.only(left: width * .02),
          width: width * .25,
          height: isLandscape(context) ? 2 * height * .1 : height * .1,
          decoration: BoxDecoration(
              border: Border.all(color: blackColor),
              borderRadius: BorderRadius.circular(5)),
        ),
        const CustomSizedBox(percentageOfHeight: .005),
        const CustomText(text: "كهرباء", textColor: blackColor)
      ],
    );
  }
}
