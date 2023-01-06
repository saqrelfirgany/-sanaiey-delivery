import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/order_details_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/service_provider_details/service_provider_details_screen.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/utils/responsive.dart';

class ServiceProviderData extends StatefulWidget {
  ServiceProviderData({Key? key, required this.orderItem}) : super(key: key);
  final OrderDetailsModel orderItem;

  @override
  State<ServiceProviderData> createState() => _ServiceProviderDataState();
}

class _ServiceProviderDataState extends State<ServiceProviderData> {
  late FavController favController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future getData() async {
    favController = Get.find<FavController>();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomText(
          text: "الفني",
          fontWeight: FontWeight.bold,
          textColor: blackColor,
        ),
        GestureDetector(
          onTap: () {
            Get.find<OrderController>().setEmployeeID(
              id: '${widget.orderItem.employee!.id}',
            );
            fadNavigate(context, ServiceProviderDetailsScreen());
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
                    GestureDetector(
                      onTap: () {
                        favController.addEmployeeToFav(
                          employeeId: '${widget.orderItem.employee!.id}',
                        );
                        setState(() {
                          widget.orderItem.employee!.isFavourite = !widget.orderItem.employee!.isFavourite;
                        });
                      },
                      child: Icon(
                        widget.orderItem.employee!.isFavourite
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart,
                        color: Colors.red.shade900,
                      ),
                    ),
                    CustomText(text: "${widget.orderItem.employee!.name}"),
                    const CustomSizedBox(percentageOfHeight: .01),
                    CustomText(
                      text: "${widget.orderItem.employee!.title}",
                    ),
                    const CustomSizedBox(percentageOfHeight: .01),
                    Row(
                      children: [
                        AbsorbPointer(
                          absorbing: true,
                          child: RatingBar(
                            initialRating: double.parse(
                              '${widget.orderItem.employee!.rate}',
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
                  child: NetImage(uri: '${widget.orderItem.employee!.image}'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
