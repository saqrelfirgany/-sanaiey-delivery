import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanaiey/constants/colors.dart';

class MainLoader extends StatelessWidget {
  const MainLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitSquareCircle(
        size: 40.w,
        color: mainColor,
      ),
    );
  }
}
