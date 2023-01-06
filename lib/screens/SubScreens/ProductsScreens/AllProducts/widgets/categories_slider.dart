
import 'package:flutter/material.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/AllProducts/widgets/singe_category_product_card.dart';
import 'package:sanaiey/utils/responsive.dart';

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      height: isLandscape(context) ? 2 * height * .15 : height * .15,
      width: width,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return const SingleCategoryProductCard();
          },
          scrollDirection: Axis.horizontal),
    );
  }
}
