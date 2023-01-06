
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_build_body.dart';
import 'package:sanaiey/custom_widgets/custom_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/widgets/look_at_cart_and_total_part.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/widgets/product_details_and_add_to_fav_button.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/widgets/product_images.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/widgets/similar_products_part.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomBuildBody(
      withCustomHeader: true,
      withPadding: false,
      customHeader: BackAppBar(),
      buildBodyWidget: SingleChildScrollView(
        child: Column(
          children: const [
            ProductImages(),
            CustomSizedBox(
              percentageOfHeight: .0,
            ),
            ProductDetailsAndAddToFavButton(),
            CustomSizedBox(
              percentageOfHeight: .0,
            ),
            CustomButton(
                text: "أضف إلى العربة",
                percentageOfWidth: .4,
                buttonColor: mainColor,
                percentageOfHeight: .05,
                fontSize: .015),
            CustomSizedBox(
              percentageOfHeight: .0,
            ),
            SimilarProductsPart(),
            LookAtCartAndTotalPartInProductDetails()
          ],
        ),
      ),
    );
  }
}
