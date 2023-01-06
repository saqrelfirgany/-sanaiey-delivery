
import 'package:flutter/material.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SubScreens/Packages/AllPackages/body/single_main_category_card.dart';
import 'package:sanaiey/screens/SubScreens/Packages/PackageMoreDetails/package_more_details.dart';
import 'package:sanaiey/utils/responsive.dart';

class MainCategoriesPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * .9,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleMainCategoryCard(
                categoryName: "تنظيف عادي",
                imagePath: "assets/icons/normal_cleaning.png",
                onTapCategoryCard: () {
                  fadNavigate(context, PackageMoreDetails());
                },
              ),
              SingleMainCategoryCard(
                categoryName: "تنظيف عميق",
                imagePath: "assets/icons/deep_cleaning.png",
                onTapCategoryCard: () {
                  fadNavigate(context, PackageMoreDetails());
                },
              ),
            ],
          ),
          CustomSizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleMainCategoryCard(
                categoryName: "تعقيم وتطهير",
                imagePath: "assets/icons/disinfecting.png",
                onTapCategoryCard: () {
                  fadNavigate(context, PackageMoreDetails());

                },
              ),
              SingleMainCategoryCard(
                categoryName: "تنظيف بعد التشطيب",
                imagePath: "assets/icons/finishing.png",
                onTapCategoryCard: () {
                  fadNavigate(context, PackageMoreDetails());

                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
