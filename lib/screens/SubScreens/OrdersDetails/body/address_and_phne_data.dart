import 'package:flutter/material.dart';
import 'package:sanaiey/Models/SubModel/order_details_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class AddressAndPhoneData extends StatelessWidget {
  const AddressAndPhoneData({Key? key, required this.orderItem}) : super(key: key);
  final OrderDetailsModel orderItem;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const CustomText(
              text: "الموقع",
              textColor: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Container(
              width: width * .3,
              height: isLandscape(context) ? 2 * height * .05 : height * .05,
              child:  Center(
                child: CustomText(
                  text: "${orderItem.cityName}",
                  textColor: greyColor,
                ),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backGroundColor),
            ),
            const CustomText(
              text: "المنطقة",
              textColor: blackColor,
              fontWeight: FontWeight.bold,
            ),
            Container(
              width: width * .3,
              height: isLandscape(context) ? 2 * height * .05 : height * .05,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backGroundColor),
              child:  Center(
                child: CustomText(text: "${orderItem.regionName}", textColor: greyColor),
              ),
            )
          ],
        ),
        const CustomSizedBox(
          percentageOfHeight: .02,
        ),
        Row(
          children: [
            const CustomIconButton(
              color: blackColor,
              icon: Icons.location_on_outlined,
            ),
            SizedBox(
              width: width * .01,
            ),
            SizedBox(
                width: width * .8,
                child:  CustomText(
                    text: "${orderItem.cityName} - ${orderItem.regionName} - ${orderItem.streetName}",
                    maxLines: 2,
                    textColor: greyColor,
                    textAlign: TextAlign.start,
                    percentageOfHeight: .016))
          ],
        ),
        const CustomSizedBox(
          percentageOfHeight: .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // const CustomText(text: "المنزل", textColor: greyColor),
            // Container(
            //   width: width * .2,
            //   height: isLandscape(context) ? 2 * height * .05 : height * .05,
            //   child: const Center(
            //     child: CustomText(text: "", textColor: greyColor),
            //   ),
            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backGroundColor),
            // ),
            const CustomText(text: "رقم العقار", textColor: greyColor),
            Container(
              width: width * .2,
              height: isLandscape(context) ? 2 * height * .05 : height * .05,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backGroundColor),
              child: Center(
                child: CustomText(text: "${orderItem.flatNumber}", textColor: greyColor),
              ),
            ),
            const CustomText(
              text: "رقم الشقة",
              textColor: greyColor,
            ),
            Container(
              width: width * .2,
              height: isLandscape(context) ? 2 * height * .05 : height * .05,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backGroundColor),
              child: Center(
                child: CustomText(text: "${orderItem.floorNumber}", textColor: greyColor),
              ),
            ),
          ],
        ),
        const CustomSizedBox(
          percentageOfHeight: .02,
        ),
        Row(
          children: [
            const CustomText(
              text: "الهاتف",
              textColor: blackColor,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(width: width * .03),
            Container(
              width: width * .75,
              height: isLandscape(context) ? 2 * height * .05 : height * .05,
              child:  Center(
                child: CustomText(
                    text: "${orderItem.phone}", textColor: greyColor, textAlign: TextAlign.start),
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backGroundColor),
            ),
          ],
        )
      ],
    );
  }
}
