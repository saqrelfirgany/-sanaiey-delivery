import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:sanaiey/utils/check_direction.dart';

import 'custom_text.dart';

class NetworkIndicatorWithoutImage extends StatefulWidget {
  final Widget child;
  const NetworkIndicatorWithoutImage({Key? key, this.child: const SizedBox()})
      : super(key: key);
  @override
  _NetworkIndicatorWithoutImageState createState() =>
      _NetworkIndicatorWithoutImageState();
}

class _NetworkIndicatorWithoutImageState
    extends State<NetworkIndicatorWithoutImage> {
  Widget _buildBodyItem() {
    return CustomText(
        text: checkDirection(
            dirArabic: "لا يوجد اتصال بالإنترنت ",
            dirEnglish: "you\'re Offline !"),
        textColor: Colors.red,
        percentageOfHeight: .018);
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
          return _buildBodyItem();
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
