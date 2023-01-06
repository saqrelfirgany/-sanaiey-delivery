import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';

AppBar ProfileAppBar2({required BuildContext context, required String title}) {
  return AppBar(
    title: Text(
      title,
      style: titleNormal(color: Colors.white),
    ),
    centerTitle: true,
    actions: [
      InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsetsDirectional.only(end: 16, start: 24),
          child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 20.w),
        ),
      ),
    ],
    automaticallyImplyLeading: false,
    backgroundColor: mainColor,
  );
}

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.h,
      padding: EdgeInsetsDirectional.only(
        start: 18.w,
        top: 8.h,
        bottom: 8.h,
        end: 8.w,
      ),
      color: mainColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Center(
            child: Text(
              title,
              style: titleNormal(color: Colors.white),
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
