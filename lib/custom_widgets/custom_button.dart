import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/font_sizes.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final double percentageOfHeight;
  final double percentageOfWidth;
  final double radius;
  final Color borderColor;
  final Color buttonColor;
  final String text;
  final bool isLoading;
  final Color textColor;
  final bool withBorders;
  final double fontSize;
  final Widget loadingWidget;
  final VoidCallback? onTapButton;
  final FontWeight fontWieght;
  const CustomButton(
      {Key? key,
      this.borderColor: mainColor,
      this.withBorders: false,
      this.isLoading: false,
      this.loadingWidget: const SizedBox(),
      this.percentageOfHeight: .075,
      this.percentageOfWidth: .9,
      this.radius: 10,
      this.buttonColor: secondaryColor,
      this.text: "bitton text ",
      this.textColor: whiteColor,
      this.fontSize: buttonFontSize,
      this.fontWieght: FontWeight.bold,
      this.onTapButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Container(
            height: isLandscape(context)
                ? 2 * height * percentageOfHeight
                : height * percentageOfHeight,
            width: isLandscape(context)
                ? width * percentageOfWidth
                : width * percentageOfWidth,
            child: Center(
                child: isLoading == true
                    ? CircularProgressIndicator(
                        backgroundColor: secondaryColor,
                        color: whiteColor,
                      )
                    : CustomText(
                        text: text,
                        fontWeight: fontWieght,
                        textColor: textColor,
                        percentageOfHeight:
                            isLandscape(context) ? 2 * fontSize : fontSize,
                      )),
            decoration: BoxDecoration(
                border:
                    withBorders == true ? Border.all(color: borderColor) : null,
                color: buttonColor,
                borderRadius: BorderRadius.circular(radius)),
          ),
          onTap: onTapButton,
        )
      ],
    );
  }
}
