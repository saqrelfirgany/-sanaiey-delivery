import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/screens/MainScreens/CartScreen/body/sheet_bill_item.dart';
import 'package:sanaiey/utils/responsive.dart';

class BillItem extends StatelessWidget {
  final String fieldValue, fieldName;
  final bool isTotal;

  const BillItem({
    Key? key,
    this.fieldName = '',
    this.fieldValue = '',
    this.isTotal = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width(context) * .9,
      // margin: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 108.w,
            child: Text(
              fieldName,
              style: isTotal ? titleBold(color: mainColor) : titleNormal(color: mainColor),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            '- - - - - - - - - - - - - - -',
            style: titleBold(color: Color(0xFFDDDDDD)),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // color: Colors.blue,
                width: 80.w,
                child: Text(
                  '$fieldValue',
                  style: isTotal ? titleBold(color: mainColor) : titleNormal(color: mainColor),
                  textAlign: TextAlign.end,
                ),
              ),
              // isTotal
              //     ? GetBuilder<CartController>(
              //         builder: (cartController) => Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             InkWell(
              //               onTap: () {
              //                 Get.bottomSheet(
              //                   StatefulBuilder(
              //                     builder: (context, setState) {
              //                       return Container(
              //                         height: 400.h,
              //                         decoration: BoxDecoration(
              //                           color: Colors.white,
              //                           borderRadius: BorderRadiusDirectional.only(
              //                             topStart: Radius.circular(16.r),
              //                             topEnd: Radius.circular(16.r),
              //                           ),
              //                         ),
              //                         child: SingleChildScrollView(
              //                           physics: BouncingScrollPhysics(),
              //                           child: Column(
              //                             mainAxisSize: MainAxisSize.min,
              //                             children: [
              //                               SizedBox(height: 8.h),
              //                               Text(
              //                                 'تفاصيل الفاتورة',
              //                                 style: titleBold(color: secondaryColor, size: 16),
              //                               ),
              //                               Padding(
              //                                 padding:
              //                                     EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              //                                 child: Divider(color: mainColor),
              //                               ),
              //                               SizedBox(height: 8.h),
              //                               ListView(
              //                                 scrollDirection: Axis.vertical,
              //                                 shrinkWrap: true,
              //                                 physics: BouncingScrollPhysics(),
              //                                 children: List.generate(
              //                                   cartController.cartModel.discountDetails.length,
              //                                   (index) => Padding(
              //                                     padding: EdgeInsets.symmetric(horizontal: 16.w),
              //                                     child: SheetBillItem(
              //                                       fieldName:
              //                                           '${cartController.cartModel.discountDetails.keys.elementAt(index)}',
              //                                       fieldValue:
              //                                           '${cartController.cartModel.discountDetails.values.elementAt(index)}',
              //                                     ),
              //                                   ),
              //                                 ),
              //                               ),
              //                             ],
              //                           ),
              //                         ),
              //                       );
              //                     },
              //                   ),
              //                 );
              //               },
              //               child: Container(
              //                 // width: 120.w,
              //                 // height: 30.h,
              //                 // decoration: decorationRadius().copyWith(
              //                 //   color: const Color(0xFFAE0910),
              //                 // ),
              //                 child: Center(
              //                   child: Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     crossAxisAlignment: CrossAxisAlignment.center,
              //                     children: [
              //                       // Text(
              //                       //   'تفاصيل',
              //                       //   style: titleNormal(color: secondaryColor, size: 14),
              //                       // ),
              //                       // SizedBox(width: 4.w),
              //                       Padding(
              //                         padding: EdgeInsets.only(top: 6.h),
              //                         child: Icon(
              //                           Icons.visibility_outlined,
              //                           color: secondaryColor,
              //                           size: 18.w,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //       )
              //     : const SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
