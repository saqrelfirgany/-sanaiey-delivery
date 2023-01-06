
import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ServiceProviderCard extends StatelessWidget {
  const ServiceProviderCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Neumorphic(
      style: const NeumorphicStyle(depth: 10),
      child: Container(
        width: width * .7,
        color: whiteColor,
        padding: EdgeInsets.only(right: width * .03, left: width * .03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const
                CustomSizedBox(percentageOfHeight: .02),
                const CustomIconButton(
                    icon: Icons.favorite_border, color: secondaryColor),
                const CustomText(text: "احمد محمد"),
                const CustomSizedBox(percentageOfHeight: .01),
                const CustomText(
                  text: "سباك",
                ),
                const CustomSizedBox(percentageOfHeight: .01),
                Row(children: [
                  Icon(Icons.star,
                      color: mainColor,
                      size: isLandscape(context)
                          ? 2 * height * 0.02
                          : height * 0.02),
                  Icon(Icons.star,
                      color: mainColor,
                      size: isLandscape(context)
                          ? 2 * height * 0.02
                          : height * 0.02),
                  Icon(Icons.star,
                      color: mainColor,
                      size: isLandscape(context)
                          ? 2 * height * 0.02
                          : height * 0.02),
                  Icon(Icons.star,
                      color: mainColor,
                      size: isLandscape(context)
                          ? 2 * height * 0.02
                          : height * 0.02),
                  Icon(Icons.star,
                      color: mainColor,
                      size: isLandscape(context)
                          ? 2 * height * 0.02
                          : height * 0.02),
                ]),
                const CustomSizedBox(percentageOfHeight: .01),
              ],
            ),
            Container(
              height: isLandscape(context) ? 2 * height * .12 : height * .12,
              width: width * .25,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  border: Border.all(color: mainColor, width: 2),
                  shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}
