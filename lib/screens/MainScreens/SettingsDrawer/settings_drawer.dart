import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/screens/SubScreens/AboutUs/about_us.dart';
import 'package:sanaiey/screens/SubScreens/FavouritesScreen/favourites_screen.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/profile_screen.dart';
import 'package:sanaiey/screens/SubScreens/TermsScreen/terms_screen.dart';
import 'package:sanaiey/screens/SubScreens/UserPointsScreen/user_points_screen.dart';
import 'package:sanaiey/utils/common_functions.dart';
import 'package:sanaiey/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCategoryDrawer extends StatefulWidget {
  final onTapYes;
  final onTapNo;
  final FocusNode? node;

  CustomCategoryDrawer({Key? key, this.node, this.onTapNo, this.onTapYes}) : super(key: key);

  @override
  _CustomCategoryDrawerState createState() => _CustomCategoryDrawerState();
}

class _CustomCategoryDrawerState extends State<CustomCategoryDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _openFacebook({required String path, required String link}) async {
    String fbProtocolUrl;
    if (Platform.isIOS) {
      fbProtocolUrl = '$path://profile/100086698353013';
    } else {
      fbProtocolUrl = '$path://page/100086698353013';
    }

    String fallbackUrl = '$link';

    try {
      Uri fbBundleUri = Uri.parse(fbProtocolUrl);
      var canLaunchNatively = await canLaunchUrl(fbBundleUri);

      if (canLaunchNatively) {
        launchUrl(fbBundleUri);
      } else {
        await launchUrl(Uri.parse(fallbackUrl), mode: LaunchMode.externalApplication);
      }
    } catch (e, st) {
      // Handle this as you prefer
    }
  }

  _launchWhatsapp({required String text, required String phone}) async {
    var whatsapp = '+201090043513';
    var whatsappAndroid = Uri.parse('whatsapp://send?phone=$whatsapp&text=كيف يمكننا مساعدتك');
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: width(context),
        color: mainColor,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const CustomSizedBox(percentageOfHeight: .06),
              Container(
                padding: EdgeInsets.only(right: width(context) * .06),
                child: Row(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      child: const Center(
                        child: Icon(Icons.close, color: mainColor, size: 20),
                      ),
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: whiteColor),
                    )
                  ],
                ),
              ),
              GetBuilder<UserController>(
                builder: (userController) => Column(
                  children: [
                    const CustomSizedBox(percentageOfHeight: .05),
                    Text(
                      'أهلاً بك !',
                      style: titleBold(color: greyColor, size: 18),
                    ),
                    const CustomSizedBox(percentageOfHeight: .01),
                    Container(
                      // color: Colors.blue,
                      width: 200.w,
                      alignment: AlignmentDirectional.center,
                      child: Text(
                        '${userController.userInfo.clientName}',
                        style: titleNormal(color: Colors.white, size: 20),
                      ),
                    ),
                    const CustomSizedBox(percentageOfHeight: .02),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        fadNavigate(context, UserPointsScreen());
                      },
                      child: Container(
                        height: isLandscape(context) ? 2 * height(context) * .12 : height(context) * .12,
                        width: width(context) * .5,
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: greyColor, width: 2),
                        //   borderRadius: BorderRadius.circular(20),
                        // ),
                        decoration: BoxDecoration(
                          // color: greyColor,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: greyColor, width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: const Offset(0, 0),
                              blurRadius: 4.0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'مجموع النقاط',
                              style: titleNormal(color: greyColor, size: 18),
                            ),
                            Container(
                              // color: Colors.blue,
                              width: 190.w,
                              alignment: AlignmentDirectional.center,
                              child: Text(
                                '${userController.userInfo.clientPoints}' ' نقطة',
                                style: titleNormal(color: Colors.white, size: 18),
                              ),
                            ),
                            CustomSizedBox(percentageOfHeight: .01),
                          ],
                        ),

                      ),
                    ),
                    const CustomSizedBox(percentageOfHeight: .03),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        fadNavigate(context, FavouritesScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: width(context) * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: width(context) * .02),
                                  Icon(Icons.favorite, color: greyColor),
                                  SizedBox(width: width(context) * .02),
                                  Text(
                                    'المفضلة',
                                    style: titleNormal(color: greyColor),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: greyColor)
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                        fadNavigate(context, ProfileScreen());
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: width(context) * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(width: width(context) * .02),
                                  Icon(Icons.settings_outlined, color: greyColor),
                                  SizedBox(width: width(context) * .02),
                                  Text(
                                    'إعدادات الحساب',
                                    style: titleNormal(color: greyColor),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: greyColor)
                          ],
                        ),
                      ),
                    ),
                    const CustomSizedBox(percentageOfHeight: .02),
                  ],
                ),
              ),

//              Image.asset(
//                "assets/icons/logo.png",
//                width: width(context) * .25 ,
//              ),
              const CustomSizedBox(percentageOfHeight: .01),
              singleSettingsRow(
                context: context,
                text: "عن الشركة",
                iconData: Icons.info_outline,
                onTap: () => fadNavigate(context, AboutUsScreen()),
              ),
              const CustomSizedBox(percentageOfHeight: .005),
              singleSettingsRow(
                context: context,
                text: "سياسة الخصوصية",
                iconData: Icons.security,
                onTap: () {
                  Navigator.of(context).pop();
                  fadNavigate(context, TermsAndConditionsScreen());
                },
              ),
              const CustomSizedBox(percentageOfHeight: .005),
              singleSettingsRow(
                  context: context,
                  text: "مشاركة التطبيق",
                  iconData: Icons.share_outlined,
                  onTap: () {
                    CommonFunctions().share(
                        text: "صنايعي دليفري",
                        title: "صنايعي دليفري",
                        linkUrl: "صنايعي دليفري",
                        chooserTitle: "صنايعي دليفري");
                  }),
              const CustomSizedBox(percentageOfHeight: .02),

              Container(
                padding: EdgeInsets.only(left: width(context) * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
//                width: width(context),
//                margin: EdgeInsets.only(bottom: isLandscape(context) ? 2*height(context)*.025 : height(context)*.025 ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: width(context) * .05),
                          Icon(Icons.minimize,
                              color: greyColor,
                              size:
                                  isLandscape(context) ? 2 * height(context) * .04 : height(context) * .04),
                          SizedBox(width: width(context) * .02),
                          const CustomText(text: "تابعنا", textColor: greyColor, percentageOfHeight: .022),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(percentageOfHeight: .01),

              GetBuilder<HomeController>(
                builder: (homeController) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    singleSocialMediaItem(
                      press: () {
                        _openFacebook(
                          path: 'fb',
                          link: '${homeController.aboutUsModel.facebook}',
                        );
                      },
                      context: context,
                      iconData: MdiIcons.facebook,
                    ),
                    SizedBox(width: 20.w),
                    singleSocialMediaItem(
                      press: () {
                        _openFacebook(
                          path: 'tw',
                          link: '${homeController.aboutUsModel.twitter}',
                        );
                      },
                      context: context,
                      iconData: MdiIcons.twitter,
                    ),
                    SizedBox(width: 20.w),
                    singleSocialMediaItem(
                      press: () {
                        openInsta(
                          link: '${homeController.aboutUsModel.instegram}',
                        );
                      },
                      context: context,
                      iconData: MdiIcons.instagram,
                    ),
                    SizedBox(width: 20.w),
                    singleSocialMediaItem(
                      press: () {
                        _launchWhatsapp(text: 'text', phone: 'phone');

                        // _openFacebook(
                        //   path: 'wt',
                        //   link: '${homeController.aboutUsModel.whatsApp}',
                        // );
                        // openInsta(
                        //   link: '${homeController.aboutUsModel.whatsApp}',
                        // );
                      },
                      context: context,
                      iconData: MdiIcons.whatsapp,
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(percentageOfHeight: .02),
              InkWell(
                onTap: () => Get.find<AuthController>().logout(),
                child: Container(
                  padding: EdgeInsets.only(left: width(context) * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: width(context) * .05),
                          Icon(Icons.logout,
                              color: greyColor,
                              size:
                                  isLandscape(context) ? 2 * height(context) * .04 : height(context) * .04),
                          SizedBox(width: width(context) * .02),
                          const CustomText(
                            text: "تسجيل الخروج",
                            textColor: greyColor,
                            percentageOfHeight: .022,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openInsta({required String link}) async {
    var url = link;

    if (await canLaunch(url)) {
      await launch(
        url,
        universalLinksOnly: true,
      );
    } else {
      throw 'There was a problem to open the url: $url';
    }
  }

  _launchURL(String url) async {
    url = url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  singleMenuItem({BuildContext? context, String image: "", VoidCallback? onTap, String text: ""}) {
    return Container(
        padding: EdgeInsets.only(right: width(context!) * .05, left: width(context) * .05),
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              Image.asset(
                image,
                height: isLandscape(context) ? 2 * height(context) * .036 : height(context) * .036,
              ),
              SizedBox(
                width: width(context) * .03,
              ),
              CustomText(textColor: Colors.green, text: text, percentageOfHeight: .025)
            ],
          ),
        ));
  }

  singleIconButton({BuildContext? context, VoidCallback? onTapIcon, String iconData: "", heignt: .04}) {
    return GestureDetector(
      onTap: onTapIcon,
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: NetworkImage(iconData), fit: BoxFit.cover)),
        height: isLandscape(context!) ? 2 * height(context) * heignt : height(context) * heignt,
        width: isLandscape(context) ? .5 * width(context) * .11 : width(context) * .11,
      ),
    );
  }

  singleSettingsRow(
      {BuildContext? context, String text: "", IconData iconData: Icons.add, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: isLandscape(context!) ? 2 * height(context) * .065 : height(context) * .065,
        width: width(context),
        color: whiteColor,
        child: Container(
          padding: EdgeInsets.only(left: width(context) * .02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
//                width: width(context),
//                margin: EdgeInsets.only(bottom: isLandscape(context) ? 2*height(context)*.025 : height(context)*.025 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: width(context) * .02),
                    Icon(iconData,
                        color: mainColor,
                        size: isLandscape(context) ? 2 * height(context) * .03 : height(context) * .03),
                    SizedBox(width: width(context) * .02),
                    CustomText(text: text, textColor: mainColor, percentageOfHeight: .02),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  singleSocialMediaItem(
      {BuildContext? context, IconData iconData: Icons.add, required VoidCallback press}) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 44.w,
        height: 44.w,
        // padding: EdgeInsets.all(6.w),
        decoration: BoxDecoration(
          border: Border.all(color: whiteColor),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            iconData,
            // size: 20.w,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
