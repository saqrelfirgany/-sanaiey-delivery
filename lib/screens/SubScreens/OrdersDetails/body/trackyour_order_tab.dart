import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/SubModel/order_details_model.dart';
import 'package:sanaiey/Models/SubModel/track_order_model.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../Helper/decoration_helper.dart';
import '../../../../constants/colors.dart';
import '../../../../custom_widgets/custom_text.dart';
import '../../../SharedComponents/net_image.dart';

class TrackYourOrderTap extends StatelessWidget {
  TrackYourOrderTap({
    Key? key,
    required this.requestTrackItem,
    required this.orderDetails,
    required this.orderDetailsTrackingModelList,
  }) : super(key: key);
  RequestTrackItemList requestTrackItem;
  OrderDetailsModel orderDetails;
  OrderDetailsTrackingModel orderDetailsTrackingModelList;
  bool isStep1 = true;
  bool isStep2 = false;
  bool isStep3 = false;

  Future<void> _makePhoneCall({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: isLandscape(context) ? 2 * height * .8 : height * .75,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomSizedBox(percentageOfHeight: .02),
            CustomSizedBox(percentageOfHeight: .02),
            Container(
              height: isLandscape(context) ? 2 * height * .20 : height * .20,
              width: width,
              child: NetImage(
                uri: '${requestTrackItem.imageURL}',
                boxFit: BoxFit.contain,
              ),
            ),
            CustomSizedBox(percentageOfHeight: .02),
            orderDetailsTrackingModelList.requestTrackItemList == null
                ? const SizedBox()
                : ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 40.h),
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                      orderDetailsTrackingModelList.requestTrackItemList!.length,
                      (index) => Container(
                        width: 120,
                        // height: 80,
                        margin: EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: NetImage(
                                    uri:
                                        '${orderDetailsTrackingModelList.requestTrackItemList![index].imageURL}',
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  width: 20,
                                  height: 20,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: mainColor),
                                  ),
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          orderDetailsTrackingModelList.requestTrackItemList![index].id ==
                                                  orderDetailsTrackingModelList.selectedTrackId
                                              ? mainColor
                                              : Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${orderDetailsTrackingModelList.requestTrackItemList![index].name}',
                                      style: titleNormal(color: mainColor),
                                    ),
                                    orderDetailsTrackingModelList.requestTrackItemList![index].id ==
                                            orderDetailsTrackingModelList.selectedTrackId
                                        ? Text(
                                            '${orderDetailsTrackingModelList.requestTrackItemList![index].actionTime}',
                                            style: titleNormal(color: Colors.black, size: 14),
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                            orderDetailsTrackingModelList.requestTrackItemList![index].id ==
                                        orderDetailsTrackingModelList.selectedTrackId &&
                                    orderDetailsTrackingModelList.requestTrackItemList![index].showEmployee
                                // true
                                ? TrackOrderStep2(width, context, height)
                                : const SizedBox(),
                            orderDetailsTrackingModelList.requestTrackItemList![index].id ==
                                        orderDetailsTrackingModelList.selectedTrackId &&
                                    orderDetailsTrackingModelList.requestTrackItemList![index].showReview
                                    // true
                                ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Button(text: 'قيم الخدمة'),
                                          ),
                                        ),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Button(text: 'اكتب شكوي'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
            CustomSizedBox(percentageOfHeight: .02),
          ],
        ),
      ),
    );
  }

  Widget TrackOrderStep2(double width, BuildContext context, double height) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              // Get.find<OrderController>().setEmployeeID(
              //   id: '${widget.orderItem.employee!.id}',
              // );
              // fadNavigate(context, ServiceProviderDetailsScreen());
            },
            child: Container(
              width: width * .7,
              padding: EdgeInsets.only(right: width * .03, left: width * .03),
              decoration: decorationRadius(color: whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomSizedBox(percentageOfHeight: .02),
                      CustomText(
                        text: "${orderDetailsTrackingModelList.selectedEmployee!.name}",
                      ),
                      const CustomSizedBox(percentageOfHeight: .01),
                      CustomText(
                        text: "${orderDetailsTrackingModelList.selectedEmployee!.title}",
                      ),
                      const CustomSizedBox(percentageOfHeight: .01),
                      Row(
                        children: [
                          AbsorbPointer(
                            absorbing: true,
                            child: RatingBar(
                              initialRating: double.parse(
                                '${orderDetailsTrackingModelList.selectedEmployee!.rate}',
                              ),
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 16.w,
                              ratingWidget: RatingWidget(
                                full: Icon(
                                  Icons.star_rounded,
                                  color: mainColor,
                                ),
                                half: Icon(
                                  Icons.star_rounded,
                                  color: mainColor,
                                ),
                                empty: Icon(
                                  Icons.star_border_rounded,
                                  color: mainColor,
                                ),
                              ),
                              itemPadding: EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                        ],
                      ),
                      const CustomSizedBox(percentageOfHeight: .01),
                    ],
                  ),
                  Container(
                    height: isLandscape(context) ? 2 * height * .12 : height * .12,
                    width: width * .25,
                    decoration: BoxDecoration(
                      // color: secondaryColor,
                      // border: Border.all(color: mainColor, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: NetImage(
                      uri: '${orderDetailsTrackingModelList.selectedEmployee!.image}',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () => _makePhoneCall(
                  url: 'tel:${orderDetailsTrackingModelList.selectedEmployee!.phone}',
                ),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Image.asset(
                      'assets/call.png',
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              GestureDetector(
                onTap: () async {
                  await FlutterLaunch.launchWhatsapp(
                    phone: '${orderDetailsTrackingModelList.selectedEmployee!.phone}',
                    message: '',
                  );
                },
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: Image.asset(
                      'assets/chat.png',
                      color: Colors.red.shade900,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 40,
      margin: EdgeInsets.all(6),
      decoration: decorationRadius(
        color: Colors.red.shade900,
      ),
      child: Center(
        child: Text(
          text,
          style: titleNormal(color: Colors.white, size: 14),
        ),
      ),
    );
  }
}
