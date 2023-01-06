import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';

class FavButton extends StatelessWidget {
  final bool isActive;
  final String buttonText;
  final VoidCallback? onTapButton;
  final double width;
  final double height;

  const FavButton({
    Key? key,
    this.isActive = false,
    this.buttonText = "",
    this.onTapButton,
    this.width = 120,
    this.height = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapButton,
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: 2,
            lightSource: LightSource.topLeft,
            shadowDarkColor: blackColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(25))),
        child: Container(
          width: width.w,
          height: height.h,
          decoration: BoxDecoration(
            color: isActive ? secondaryColor : whiteColor,
          ),
          child: Center(
            child: CustomText(
              text: buttonText,
              textColor: isActive ? whiteColor : greyColor,
            ),
          ),
        ),
      ),
    );
  }
}
