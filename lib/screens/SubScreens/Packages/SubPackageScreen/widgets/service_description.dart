
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ServiceDescription extends StatelessWidget {
  const ServiceDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .9,
      child: Row(
        children: [
          Container(
            height: isLandscape(context) ? 2 * height * .06 : height * .06,
            width: width * .1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/normal_cleaning.png")),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  width: width * .8,
                  child: const CustomText(
                    text: "تنظيف عادي",
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                    textColor: blackColor,
                  )),
              const CustomSizedBox(
                percentageOfHeight: .01,
              ),
              SizedBox(
                  width: width * .8,
                  child: const CustomText(
                    text: "مساحة منزل من 80 - 120 متر",
                    textAlign: TextAlign.start,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
