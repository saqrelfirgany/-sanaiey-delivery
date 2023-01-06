
import 'package:flutter/material.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/utils/responsive.dart';

class ChooseServiceProviderHeader extends StatelessWidget {
  const ChooseServiceProviderHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              right: defaultHeaderPadding * width(context),
              left: defaultHeaderPadding * width(context),
              top: isLandscape(context)
                  ? .4 * 2 * defaultHeaderHeight * height(context)
                  : .4 * defaultHeaderHeight * height(context)),
          height: isLandscape(context)
              ? 2 * defaultHeaderHeight * height(context) * .8
              : defaultHeaderHeight * height(context) * .8,
          width: width(context),
          color: mainColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              const CustomText(textColor: whiteColor, text: "عربة التسوق"),
              CustomIconButton(
                  onTap: () {
                    fadNavigate(context, HomeScreen());
                  },
                  icon: Icons.arrow_forward_ios_outlined,
                  size: defaultIconSize)
            ],
          ),
        ),
        const CustomSizedBox(percentageOfHeight: .002),
        Container(
          decoration: const BoxDecoration(color: mainColor),
          height: isLandscape(context) ? 2 * height(context) * .025 : height(context) * .025,
          width: width(context),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_back_ios,
                  color: whiteColor,
                  size: isLandscape(context) ? 2 * height(context) * .015 : height(context) * .015),
              SizedBox(
                width: width(context) * .01,
              ),
              SizedBox(
                  child: const CustomText(
                      text: "Mase el gededa Roxy", maxLines: 1, percentageOfHeight: .010, textColor: whiteColor),
                  width: width(context) * .25),
              SizedBox(
                width: width(context) * .01,
              ),
              Icon(Icons.my_location,
                  color: whiteColor,
                  size: isLandscape(context) ? 2 * height(context) * .015 : height(context) * .015),
            ],
          )),
        ),
      ],
    );
  }
}
