import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';

class DepartmentHeader extends StatelessWidget {
  const DepartmentHeader({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38.h,
      width: double.infinity,
      // margin: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadiusDirectional.only(
          bottomStart: Radius.circular(20.r),
          bottomEnd: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: const Offset(0, 0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: Center(
        child: Text(
          text,
          style: titleBold(color: Colors.white),
        ),
      ),
    );
  }
}
