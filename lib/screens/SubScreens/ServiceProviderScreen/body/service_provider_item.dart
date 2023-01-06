import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/MianModels/provider_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/service_provider_details/service_provider_details_screen.dart';

class ProviderOrderItem extends StatefulWidget {
  const ProviderOrderItem({Key? key, required this.item, required this.index}) : super(key: key);
  final ProviderModel item;
  final int index;

  @override
  State<ProviderOrderItem> createState() => _ProviderOrderItemState();
}

class _ProviderOrderItemState extends State<ProviderOrderItem> {
  late FavController favController;
  int _providerIndex = -1;

  @override
  void initState() {
    super.initState();
    favController = Get.find<FavController>();
    _providerIndex = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: PhysicalModel(
        color: Colors.white,
        elevation: 3,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: () {
            setState(() {
              _providerIndex = widget.index;
            });
          },
          child: Container(
            height: 120.h,
            width: 370.w,
            decoration: decorationRadius(
              color: _providerIndex == widget.index ? backGroundColor : Colors.white,
            ),
            // margin: EdgeInsets.all(8.w),
            padding: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 16.w,
              bottom: 8.w,
              top: 8.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 330.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${widget.item.name}',
                                style: titleBold(color: Colors.black, size: 14),
                              ),
                              Text(
                                '${widget.item.title}',
                                style: titleNormal(color: Colors.black, size: 12),
                              ),
                              SizedBox(height: 8.h),
                              AbsorbPointer(
                                absorbing: true,
                                child: RatingBar(
                                  initialRating: double.parse('${widget.item.rate}'),
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemSize: 20.w,
                                  ratingWidget: RatingWidget(
                                    full: Icon(Icons.star_rounded, color: Colors.red.shade900),
                                    half: Icon(Icons.star_rounded, color: Colors.red.shade900),
                                    empty: Icon(Icons.star_border_rounded, color: Colors.red.shade900),
                                  ),
                                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 38,
                            child: FlutterLogo(size: 45),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        fadNavigate(context, ServiceProviderDetailsScreen());
                      },
                      child: Container(
                        width: 80,
                        height: 20,
                        decoration: decorationRadius(color: Color(0xFFBEBEBE)),
                        child: FittedBox(
                          child: Text(
                            'تفاصيل',
                            style: titleNormal(color: Color(0xFFAE0910)),
                          ),
                        ),
                      ),
                    )
                  ],
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
          ),
        ),
      ),
    );
  }
}
