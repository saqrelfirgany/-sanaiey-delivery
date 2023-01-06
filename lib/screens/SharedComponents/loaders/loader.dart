import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanaiey/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key, this.color = mainColor}) : super(key: key);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(
      size: 30.w,
      color: color,
    );
  }
}
