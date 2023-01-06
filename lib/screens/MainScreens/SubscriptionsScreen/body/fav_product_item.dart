import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/screens/SubScreens/ProductsScreens/ProductDetails/product_details_screen.dart';

import 'fav_service_item.dart';

class FavProductItem extends StatefulWidget {
  const FavProductItem({Key? key}) : super(key: key);

  @override
  State<FavProductItem> createState() => _FavProductItemState();
}

class _FavProductItemState extends State<FavProductItem> {
  late FavController favController;

  @override
  void initState() {
    super.initState();
    favController = Get.find<FavController>();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => fadNavigate(context, ProductDetailsScreen()),
      child: Container(
        height: 220.h,
        width: 360.w,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(width: 1, color: Colors.grey.shade500),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.8),
              offset: const Offset(0, 0),
              blurRadius: 8.0,
            )
          ],
        ),
        margin: EdgeInsets.all(8.w),
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          bottom: 8.w,
          top: 8.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 90.h,
              // width: 300.w,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/images/delivery_man1.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/no_fav_items.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Expanded(
                    child: Image.asset(
                      'assets/images/no_cart_items.png',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'اسم المنتج',
                      style: titleBold(color: Colors.black, size: 14),
                    ),
                    InkWell(
                      onTap: () {
                        // favController.addToFav(serviceId: '${widget.item.serviceId}');
                        // favController.removeFromFavList(index: widget.index);
                      },
                      child: Icon(CupertinoIcons.heart_fill, color: Colors.red.shade900),
                    )
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تفاصيل اخري',
                          style: titleNormal(color: Colors.grey.shade700, size: 12),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '150 ج',
                              style: titleBold(color: Colors.black, size: 14),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '200 ج',
                              style: titleNormal(color: Colors.grey.shade800, size: 12).copyWith(
                                  decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      width: 122.w,
                      height: 34.h,
                      decoration: decorationRadiusBorder(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 38.w,
                              height: 34.h,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(24.r),
                                  bottomStart: Radius.circular(24.r),
                                ),
                                color: const Color(0xFF00385B),
                              ),
                              child: IconButton(
                                alignment: Alignment.topCenter,
                                onPressed: () {},
                                icon: Icon(
                                  CupertinoIcons.plus,
                                  color: Colors.white,
                                  size: 18.w,
                                ),
                              ),
                            ),
                          ),

                          ///
                          /// Divider
                          ///
                          const CartDivider(),
                          Container(
                            width: 38.w,
                            height: 30.h,
                            child: Center(
                              child: Text(
                                '0',
                                style: cairoW600(
                                  color: Colors.grey.shade900,
                                  size: 14,
                                ),
                              ),
                            ),
                          ),

                          ///
                          /// Divider
                          ///
                          const CartDivider(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 38.w,
                              height: 34.h,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(24.r),
                                  bottomEnd: Radius.circular(24.r),
                                ),
                                color: Colors.white,
                              ),
                              child: IconButton(
                                alignment: Alignment.topCenter,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove,
                                  color: Colors.grey.shade900,
                                  size: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
