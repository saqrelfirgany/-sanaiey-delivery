
import 'package:flutter/material.dart';
import 'package:sanaiey/Models/SubModel/order_details_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_button.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SubScreens/OrdersDetails/body/service_provider_data.dart';
import 'package:sanaiey/utils/responsive.dart';

import 'add_other_service_button.dart';
import 'address_and_phne_data.dart';
import 'bill_details_data.dart';
import 'dashed_line.dart';
import 'order_card.dart';
import 'order_number.dart';

class OrderStatusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
        height: isLandscape(context) ? 2 * height * .8 : height * .75,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children:  [
              CustomSizedBox(
                percentageOfHeight: .01,
              ),
              OrderNumber(),
              // OrderCard(),
              // AddOtherServicesButton(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              DashedLine(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              // AddressAndPhoneData(orderItem: OrderDetailsModel(),),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              DashedLine(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              // ServiceProviderData(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              DashedLine(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              BillDetailsData(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              DashedLine(),
              CustomSizedBox(
                percentageOfHeight: .02,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        onTapButton: () {},
                        percentageOfWidth: .39,
                        buttonColor: secondaryColor,
                        textColor: whiteColor,
                        text: "طلب فني آخر",
                      ),
                      CustomButton(
                        onTapButton: () {},
                        percentageOfWidth: .49,
                        borderColor: secondaryColor,
                        buttonColor: whiteColor,
                        withBorders: true,
                        textColor: secondaryColor,
                        text: "إلغاء الطلب",
                      )
                    ],
                  ),
                  const CustomSizedBox(
                    percentageOfHeight: .02,
                  ),
                  CustomButton(
                    onTapButton: () {},
                    borderColor: secondaryColor,
                    buttonColor: whiteColor,
                    withBorders: true,
                    textColor: secondaryColor,
                    text: "تأجيل الموعد",
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
