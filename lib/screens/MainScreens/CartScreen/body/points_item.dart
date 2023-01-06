import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class PointsItem extends StatefulWidget {
  PointsItem({Key? key, this.isActive = false}) : super(key: key);
  bool isActive;

  @override
  State<PointsItem> createState() => _PointsItemState();
}

class _PointsItemState extends State<PointsItem> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Switch(
                  focusColor: greyColor,
                  activeColor: mainColor,
                  inactiveTrackColor: Colors.grey,
                  value: isActive,
                  onChanged: (n) {
                    setState(() {
                      isActive = !isActive;
                    });
                  }),
              SizedBox(width: 8.w),
              Container(
                width: 280.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: backGroundColor,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    'رصيد نقاطك : 200 نقطة = 10 ج',
                    style: titleNormal(color: Colors.grey.shade700),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 4.h),
        Container(
          padding: EdgeInsets.only(left: width(context) * .05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: "* ستحصل على خمس نقاط عند طلب الخدمة",
                percentageOfHeight: .015,
                textColor: secondaryColor,
              )
            ],
          ),
        ),
      ],
    );
  }
}
