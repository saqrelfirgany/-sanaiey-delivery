import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';

class ProfileItem extends StatelessWidget {
  ProfileItem({Key? key, required this.title, required this.value, required this.press}) : super(key: key);
  final String title;
  final String value;
  VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleNormal(color: Colors.black87),
              ),
              Row(
                children: [
                  SizedBox(width: 12.w),
                  Container(
                    width: 230.w,
                    // color: Colors.blue,
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      value,
                      textAlign:TextAlign.end,
                      style: titleNormal(color: greyColor),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black87,
                    size: 20,
                  ),
                  // SizedBox(width: 8.w),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: const Divider(thickness: 1, color: greyColor),
          )
        ],
      ),
    );
  }
}
