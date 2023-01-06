
import 'package:flutter/cupertino.dart';
import 'package:sanaiey/constants/colors.dart';

class SingleOrderTrackingDotDot extends StatelessWidget {
  const SingleOrderTrackingDotDot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 2,
      width: 2,
      decoration: const BoxDecoration(color: greyColor),
    );
  }
}
