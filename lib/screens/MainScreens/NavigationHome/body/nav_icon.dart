import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/constants/colors.dart';

class NavIcon extends StatelessWidget {
  const NavIcon({
    Key? key,
    required this.index,
    required this.currentIndex,
    required this.activeImage,
    required this.image,
  }) : super(key: key);
  final int index;
  final int currentIndex;
  final String activeImage;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          margin: EdgeInsets.only(bottom: 8.h),
          child: Image.asset(
            index == currentIndex ? activeImage : image,
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        index == currentIndex
            ? Container(
          width: 10.w,
          height: 10.w,
          decoration:  BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.shade900,
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}
