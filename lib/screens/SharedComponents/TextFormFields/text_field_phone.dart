import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/langs/translation.dart';
import 'package:sanaiey/utils/responsive.dart';

class TextFieldPhone extends StatelessWidget {
  TextFieldPhone({
    Key? key,
    required this.controller,
    this.hint = '',
    this.textInputType = TextInputType.number,
    this.obscureText= false,
  }) : super(key: key);
  final ValueNotifier<TextDirection> _textDir = ValueNotifier(TextDirection.ltr);
  final TextEditingController controller;
  final String hint;
  final TextInputType textInputType;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width(context) * .5,
      height: 46.h,
      child: ValueListenableBuilder<TextDirection>(
        valueListenable: _textDir,
        builder: (context, value, child) => TextFormField(
          controller: controller,
          keyboardType: textInputType,
          textDirection: value,
          obscureText: obscureText,
          decoration: InputDecoration(
            focusColor: mainColor,
            hoverColor: mainColor,
          ),
          onChanged: (input) {
            if (input.trim().length < 2) {
              final dir = getDirection(input);
              if (dir != value) _textDir.value = dir;
            }
          },
        ),
      ),
    );
  }
}
