import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/utils/langs/translation.dart';

class TextFieldCoupon extends StatelessWidget {
  TextEditingController couponController = TextEditingController();

  TextFieldCoupon({
    Key? key,
    // required this.controller,
    this.hint = '',
    this.textInputType = TextInputType.text,
  }) : super(key: key);
  final ValueNotifier<TextDirection> _textDir = ValueNotifier(TextDirection.ltr);

  // final TextEditingController controller;
  final String hint;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 46.h,
      // decoration: decorationDoubleRadius().copyWith(color: Color(0xFFF2F2F2)),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(26.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 0),
            blurRadius: 4.0,
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      padding: EdgeInsetsDirectional.only(start: 8.w),
      child: ValueListenableBuilder<TextDirection>(
        valueListenable: _textDir,
        builder: (context, value, child) => TextFormField(
          controller: couponController,
          keyboardType: textInputType,
          textDirection: value,
          style: titleNormal(color: Colors.grey.shade600),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            border: InputBorder.none,
            hintText: 'اضافة كوبون الخصم',
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
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
