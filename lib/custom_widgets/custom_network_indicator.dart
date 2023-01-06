import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sanaiey/utils/check_direction.dart';

import '../constants/colors.dart';
import '../utils/responsive.dart';
import 'custom_sized_box.dart';
import 'custom_text.dart';

class NetworkIndicator extends StatefulWidget {
  final Widget child;
  const NetworkIndicator({Key? key, this.child: const SizedBox()})
      : super(key: key);
  @override
  _NetworkIndicatorState createState() => _NetworkIndicatorState();
}

class _NetworkIndicatorState extends State<NetworkIndicator> {
  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        Column(
          children: [
            CustomSizedBox(percentageOfHeight: isLandscape(context) ? .1 : .3),
            const Icon(Icons.wifi_off_outlined, color: mainColor, size: 30),
            const CustomSizedBox(percentageOfHeight: .02),
            CustomText(
                text: checkDirection(
                    dirArabic: "لا يوجد اتصال بالإنترنت ",
                    dirEnglish: "you\'re Offline !"))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: _buildBodyItem(),
          );
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return widget.child;
      },
    );
  }
}
