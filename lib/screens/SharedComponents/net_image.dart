import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/constants/colors.dart';

class NetImage extends StatelessWidget {
  final String uri;
  final BoxFit boxFit;

  const NetImage({Key? key, required this.uri, this.boxFit = BoxFit.fill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      uri,
      headers: {'Authorization': "Bearer ${Helper.token}"},
      width: double.infinity,
      height: double.infinity,
      fit: boxFit,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SpinKitFadingCircle(
            size: 30.w,
            color: mainColor,
          ),
        );
      },
      errorBuilder: (
        BuildContext context,
        Object exception,
        StackTrace? stackTrace,
      ) {
        return Image.asset(
          'assets/images/delivery_man1.png',
          fit: BoxFit.fill,
        );
      },
    );
  }
}
