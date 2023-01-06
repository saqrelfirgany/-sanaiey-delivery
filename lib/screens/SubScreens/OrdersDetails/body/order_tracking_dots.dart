
import 'package:flutter/cupertino.dart';
import 'package:sanaiey/screens/SubScreens/OrdersDetails/body/single_order_tracking_dot.dart';
import 'package:sanaiey/utils/responsive.dart';

class OrderTrackingDots extends StatelessWidget {
  const OrderTrackingDots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: isLandscape(context) ? 2 * height * .1 : height * .1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot(),
          SingleOrderTrackingDotDot()
        ],
      ),
    );
  }
}
