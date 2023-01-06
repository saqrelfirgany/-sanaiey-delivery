import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/constants/spacing_and_sizes.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SharedComponents/Image/open_image_picker.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubScreens/ServicesScreen/service_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddServiceAndImage extends StatefulWidget {
  const AddServiceAndImage({Key? key, required this.depId}) : super(key: key);
  final String depId;

  @override
  State<AddServiceAndImage> createState() => _AddServiceAndImageState();
}

class _AddServiceAndImageState extends State<AddServiceAndImage> {
  bool isDeletingImage = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (cartController) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: () {
                cartController.attachmentList.isEmpty
                    ? openImagePicker(isOnePop: true)
                    : Get.bottomSheet(
                        StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              height: 490.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.only(
                                  topStart: Radius.circular(16.r),
                                  topEnd: Radius.circular(16.r),
                                ),
                              ),
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 360.w,
                                      height: 420.h,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        physics: BouncingScrollPhysics(),
                                        children: List.generate(
                                          cartController.attachmentList.length,
                                          (index) => Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: 360.w,
                                                height: 380.h,
                                                // color: Colors.blue,
                                                decoration: decorationRadius(),
                                                margin: EdgeInsetsDirectional.only(
                                                  start: index > 0 ? 8.w : 0,
                                                  top: 8.h,
                                                  bottom: 8.h,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  child: NetImage(
                                                    uri:
                                                        'https://${cartController.attachmentList[index].filePath}',
                                                  ),
                                                ),
                                              ),
                                              PositionedDirectional(
                                                bottom: 10.h,
                                                child: SizedBox(
                                                  width: 360.w,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      AnimatedSmoothIndicator(
                                                        activeIndex: index,
                                                        count: cartController.attachmentList.length,
                                                        effect: ScrollingDotsEffect(
                                                          dotWidth: 6.h,
                                                          // expansionFactor: 2.6,
                                                          dotHeight: 6.h,
                                                          dotColor: Colors.grey,
                                                          activeDotColor: Color(0xFF00385B),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              isDeletingImage
                                                  ? PositionedDirectional(
                                                      start: index > 0 ? 12.w : 8.w,
                                                      top: 12.h,
                                                      child: Container(
                                                        width: 42.w,
                                                        height: 42.w,
                                                        padding: EdgeInsets.all(4.w),
                                                        decoration: BoxDecoration(
                                                          shape: BoxShape.circle,
                                                          color: mainColor,
                                                        ),
                                                        child: Center(
                                                          child: loader,
                                                        ),
                                                      ),
                                                    )
                                                  : PositionedDirectional(
                                                      start: index > 0 ? 12.w : 8.w,
                                                      top: 12.h,
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            isDeletingImage = true;
                                                          });
                                                          cartController
                                                              .removeImage(
                                                            id: '${cartController.attachmentList[index].attachmentId}',
                                                          )
                                                              .then((value) {
                                                            setState(() {
                                                              isDeletingImage = false;
                                                            });
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 42.w,
                                                          height: 42.w,
                                                          padding: EdgeInsets.all(4.w),
                                                          decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                          child: Center(
                                                            child: Icon(
                                                              Icons.delete_forever_sharp,
                                                              color: Colors.red.shade900,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => openImagePicker(),
                                      child: Container(
                                        width: 120.w,
                                        height: 50.h,
                                        margin: EdgeInsets.all(8),
                                        decoration: decorationRadius(color: Colors.red.shade900),
                                        child: Center(
                                          child: Text(
                                            'اضافة صورة',
                                            style: cairoW400(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        isScrollControlled: true,
                      );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(
                    text: cartController.attachmentList == null
                        ? ''
                        : cartController.attachmentList.isEmpty
                            ? 'صور المشكله'
                            : 'عرض الصور',
                    textColor: secondaryColor,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.camera_alt,
                    color: secondaryColor,
                  ),
                ],
              ),
            ),
            // GetBuilder<DepartmentController>(
            //   builder: (controller) => InkWell(
            //     onTap: () {
            //       controller.setServiceId(
            //         id: widget.depId,
            //       );
            //       controller.setDepartmentSub0Id(
            //         id: widget.depId,
            //         name: '',
            //       );
            //       fadNavigate(
            //         context,
            //         ServicesScreen(
            //           text: 'widget.text',
            //           subText: 'widget.subText',
            //           description: 'widget.description',
            //         ),
            //       );
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         const CustomText(text: "إضافة خدمة", textColor: secondaryColor),
            //         SizedBox(width: 8.w),
            //         CustomIconButton(
            //           onTap: () {},
            //           icon: Icons.add,
            //           color: secondaryColor,
            //           size: defaultIconSize * .8,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
