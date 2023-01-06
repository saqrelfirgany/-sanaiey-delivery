import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';

import 'main_loader.dart';

class ScreenLoader extends StatelessWidget {
  const ScreenLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 414.w,
      height: 600.h,
      child: Center(child: MainLoader()),
    );
  }
}