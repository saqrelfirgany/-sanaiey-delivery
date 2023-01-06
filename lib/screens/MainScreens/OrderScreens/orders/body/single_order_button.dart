import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';

OrderTypeButton({
  BuildContext? context,
  bool isActive = false,
  String buttonText = "",
  VoidCallback? onTapButton,
}) {
  return InkWell(
    onTap: onTapButton,
    child: Neumorphic(
      style: NeumorphicStyle(
        depth: 1,
        lightSource: LightSource.topLeft,
        shadowDarkColor: blackColor,
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(20),
        ),
      ),
      child: Container(
        height: 35.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: isActive ? mainColor : whiteColor,
          border: isActive ? null : null,
          borderRadius: BorderRadius.circular(defaultButtonRadius),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              buttonText,
              style: isActive ? titleNormal(color: whiteColor, size: 14) : titleNormal(color: mainColor, size: 14),
            ),
          ),
        ),
      ),
    ),
  );
}
