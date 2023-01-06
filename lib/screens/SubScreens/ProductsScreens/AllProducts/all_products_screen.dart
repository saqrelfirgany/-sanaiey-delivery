
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_build_body.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SubScreens/Packages/SubPackageScreen/widgets/look_at_cart_and_total_part.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/AllProducts/widgets/categories_slider.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/AllProducts/widgets/products_gride_view.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/AllProducts/widgets/top_images_part_in_products_gallery.dart';
import 'package:sanaiey/utils/responsive.dart';

class ProductsGalleryScreen extends StatelessWidget {
  const ProductsGalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: LookAtCartAndTotalPart(),
      body: CustomBuildBody(
        customHeader: BackAppBar(),
        withPadding: false,
        withCustomHeader: true,
        buildBodyWidget: Container(
          height: isLandscape(context)
              ? 2 * height(context) * .8
              : height(context) * .8,
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leading: null,
                    expandedHeight: isLandscape(context)
                        ? 2 * height(context) * .4
                        : height(context) * .4,
                    floating: false,
                    backgroundColor: whiteColor,
                    elevation: 0,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                        background: Column(
                      children: const [
                        TopImagesPartInProductGallery(),
                        CustomSizedBox(
                          percentageOfHeight: .02,
                        ),
                        CategoriesSlider(),
                      ],
                    )),
                  )
                ];
              },
              body: const ProductsGridView()),
        ),
      ),
    );
  }
}
