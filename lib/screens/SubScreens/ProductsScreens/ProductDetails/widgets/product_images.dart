
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/utils/responsive.dart';

class ProductImages extends StatelessWidget {
  const ProductImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Neumorphic(
          child: Container(
            decoration: const BoxDecoration(color: backGroundColor),
            width: width(context) * .9,
            height: isLandscape(context)
                ? 2 * height(context) * .2
                : height(context) * .2,
          ),
        ),
        const CustomSizedBox(
          percentageOfHeight: .01,
        ),
        // ignore: sized_box_for_whitespace
        Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Neumorphic(
                child: Container(
                  decoration: const BoxDecoration(color: backGroundColor),
                  width: width(context) * .28,
                  height: isLandscape(context)
                      ? 2 * height(context) * .1
                      : height(context) * .1,
                ),
              ),
              Neumorphic(
                child: Container(
                  decoration: const BoxDecoration(color: backGroundColor),
                  width: width(context) * .28,
                  height: isLandscape(context)
                      ? 2 * height(context) * .1
                      : height(context) * .1,
                ),
              ),
              Neumorphic(
                child: Container(
                  decoration: const BoxDecoration(color: backGroundColor),
                  width: width(context) * .28,
                  height: isLandscape(context)
                      ? 2 * height(context) * .1
                      : height(context) * .1,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
