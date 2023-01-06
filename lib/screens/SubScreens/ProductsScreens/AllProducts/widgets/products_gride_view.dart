
import 'package:flutter/material.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/AllProducts/widgets/single_product_card_in_gride_view.dart';
import 'package:sanaiey/utils/responsive.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width,
      height: isLandscape(context) ? 2 * height * .65 : height * .65,
      child: Center(
        child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isLandscape(context) ? 2 : 2,
                childAspectRatio: isLandscape(context) ? 2 * .9 : .9,
                mainAxisSpacing: .1,
                crossAxisSpacing: .1),
            itemBuilder: (BuildContext context, int index) {
              return SingleProductInGridView();
            }),
      ),
    );
  }
}
