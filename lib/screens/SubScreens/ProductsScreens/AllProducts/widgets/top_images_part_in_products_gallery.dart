
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class TopImagesPartInProductGallery extends StatelessWidget {
  const TopImagesPartInProductGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          height: isLandscape(context) ? 2 * height * .18 : height * .18,
          width: width,
          decoration: BoxDecoration(color: greyColor.withOpacity(.3)),
        ),
        Container(
          height: isLandscape(context) ? 2 * height * .07 : height * .07,
          width: width,
          decoration: const BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20)),
          ),
          child: const Center(
            child: CustomText(
              text: "خدمة النظافة المنزلية",
              percentageOfHeight: .02,
              textColor: whiteColor,
            ),
          ),
        ),
      ],
    );
  }
}
