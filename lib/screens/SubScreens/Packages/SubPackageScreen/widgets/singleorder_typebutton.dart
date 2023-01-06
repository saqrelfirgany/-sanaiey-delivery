
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class SingleOrderTypeButton extends StatelessWidget {
  final bool isActive;
  final String buttonText;
  final VoidCallback? onTapButton;
  const SingleOrderTypeButton(
      {this.isActive: false, this.buttonText: "", this.onTapButton});
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
          child: Center(
            child: CustomText(
                text: buttonText, textColor: isActive ? whiteColor : greyColor),
          ),
          height: isLandscape(context)
              ? 2 * height(context) * .05
              : height(context) * .05,
          width: width(context) * .4,
          decoration: BoxDecoration(
            color: isActive ? secondaryColor : whiteColor,
          ),
        ),
      ),
    );
  }
}
