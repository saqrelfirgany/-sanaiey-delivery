import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/utils/langs/translation.dart';

class TextFieldAddress extends StatelessWidget {
  TextFieldAddress({
    Key? key,
    required this.controller,
    this.hint = '',
    this.textInputType = TextInputType.number,
    this.height = 46,
  }) : super(key: key);
  final ValueNotifier<TextDirection> _textDir = ValueNotifier(TextDirection.ltr);
  final TextEditingController controller;
  final String hint;
  final TextInputType textInputType;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GetShadow1(
      child: Container(
        width: double.infinity,
        height: height.h,
        decoration: decorationRadius().copyWith(color: Color(0xFFF2F2F2)),
        padding: EdgeInsetsDirectional.only(start: 8.w),
        child:TextFormField(
          controller: controller,
          keyboardType: textInputType,
          maxLines: 10,
          style: titleNormal(color: Colors.grey.shade600),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            hintText: hint,
            hintStyle:titleNormal(color: Colors.grey.shade600),
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
