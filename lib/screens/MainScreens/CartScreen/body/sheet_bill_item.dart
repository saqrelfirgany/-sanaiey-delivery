import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/responsive.dart';

class SheetBillItem extends StatelessWidget {
  final String fieldValue, fieldName;
  final bool isTotal;

  const SheetBillItem({
    Key? key,
    this.fieldName = '',
    this.fieldValue = '',
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width(context) * .9,
          // margin: EdgeInsets.only(bottom: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130.w,
                child: Text(
                  fieldName,
                  style: isTotal
                      ? titleBold(color: mainColor, size: 14)
                      : titleNormal(color: mainColor, size: 14),
                  maxLines: 2,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '- - - - - - - - -',
                style: titleBold(color: Color(0xFFDDDDDD)),
              ),
              SizedBox(width: 8.w),
              Container(
                width: 132.w,
                child: Text(
                  '$fieldValue',
                  style: isTotal
                      ? titleBold(color: mainColor, size: 14)
                      : titleNormal(color: mainColor, size: 14),
                  maxLines: 2,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 24.w),
      ],
    );
  }
}
