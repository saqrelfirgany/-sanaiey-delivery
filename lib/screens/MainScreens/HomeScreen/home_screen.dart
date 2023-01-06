// ignore_for_file: unused_import

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';
import 'package:sanaiey/custom_widgets/bold_title_row.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/department_screen.dart';
import 'package:sanaiey/screens/MainScreens/NavigationHome/body/cart_nav_icon.dart';
import 'package:sanaiey/screens/MainScreens/NavigationHome/body/nav_icon.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/Alerts/show_error.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/home_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/bottom_nav_bar.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';
import 'package:sanaiey/screens/SubScreens/OffersScreen/offers_screen.dart';
import 'package:sanaiey/screens/SubScreens/Packages/AllPackages/all_packages.dart';
import 'package:sanaiey/utils/responsive.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  @override
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<HomeController>().getHomeData();
  }

  int _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    int _current = 0;
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      // key: _drawerKey,
      drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            HomeAppBar(title: 'الصفحة الرئيسية'),
            // SizedBox(height: 40),
            Container(
              width: 414.w,
              height: 600.h,
              child: GetBuilder<HomeController>(
                builder: (controller) => controller.homeStage == HomeStage.LOADING
                    ? ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(height: 8.h),
                              HomeSlider(),
                              SizedBox(height: 8.h),
                              HomeDotsSlider(),
                              SizedBox(height: 12.h),
                              HomeOffers(),
                              HomeDepartments(),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CartNavIcon(),
      bottomNavigationBar: BottomNavBar(),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(16.r),
      //     topRight: Radius.circular(16.r),
      //   ),
      //   child: AnimatedBottomNavigationBar(
      //     icons: <IconData>[
      //       Icons.brightness_5,
      //       Icons.brightness_4,
      //       Icons.shopping_cart_outlined,
      //       Icons.brightness_6,
      //       Icons.home,
      //     ],
      //     activeIndex: _bottomNavIndex,
      //     gapLocation: GapLocation.none,
      //     notchSmoothness: NotchSmoothness.verySmoothEdge,
      //     height: 70.h,
      //     activeColor: Colors.white,
      //     backgroundColor: mainColor,
      //     // elevation: 10,
      //     // leftCornerRadius: 32,
      //     // rightCornerRadius: 32,
      //     onTap: (index) => setState(() => _bottomNavIndex = index),
      //     //other params
      //   ),
      // ),
    );
  }
}

final iconList = <IconData>[
  Icons.brightness_5,
  Icons.brightness_4,
  Icons.brightness_6,
  Icons.brightness_7,
];

//
class HomeDotsSlider extends StatelessWidget {
  const HomeDotsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => AnimatedSmoothIndicator(
        activeIndex: controller.sliderIndex,
        count: controller.sliderList.length,
        effect: ExpandingDotsEffect(
          dotWidth: 10,
          expansionFactor: 2.6,
          dotHeight: 10,
          dotColor: Colors.grey,
          activeDotColor: Color(0xFF00385B),
        ),
      ),
    );
  }
}

class HomeSlider extends StatelessWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SizedBox(
        width: width(context),
        height: 140.h,
        child: SizedBox(
          width: width(context),
          height: height(context) * .2,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: .8,
              aspectRatio: 0.1,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
              onPageChanged: (index, reason) {
                controller.changeSliderIndex(index: index);
              },
            ),
            items: controller.sliderList
                .map(
                  (item) => Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: GetShadow(
                      child: Container(
                        width: double.infinity,
                        height: 170.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: NetImage(uri: item.imagePath),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class DepartmentSlider extends StatelessWidget {
  const DepartmentSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SizedBox(
        width: width(context),
        height: 120.h,
        child: SizedBox(
          width: width(context),
          height: height(context) * .2,
          child: CarouselSlider(
            options: CarouselOptions(
              viewportFraction: .8,
              aspectRatio: 0.1,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              autoPlay: true,
            ),
            items: controller.sliderList
                .map(
                  (item) => Container(
                    width: double.infinity,
                    height: 170.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: NetImage(uri: item.imagePath),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class HomeOffers extends StatelessWidget {
  const HomeOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        width: double.infinity,
        height: 180.h,
        color: const Color(0xFFF4F4F4),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            const TitleRow(text: "أحدث العروض"),
            Container(
              width: double.infinity,
              height: 100.h,
              margin: EdgeInsetsDirectional.all(16.w),
              // alignment: Alignment.center,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  controller.offersList.length,
                  (index) => InkWell(
                    onTap: () {
                      controller.setOfferId(
                        id: '${controller.offersList[index].itemId}',
                      );
                      fadNavigate(context, OffersScreen());
                    },
                    child: Container(
                      height: 100.h,
                      width: 120.w,
                      margin: EdgeInsetsDirectional.all(4.w),
                      // decoration: decorationRadius(),
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: NetImage(
                          uri: controller.offersList[index].imagePath,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeDepartments extends StatelessWidget {
  const HomeDepartments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16.h),
            TitleRow(text: "خدماتنا , كيف نقدر نساعدك اليوم"),
            Container(
              width: double.infinity,
              // height: 500.h,
              margin: EdgeInsetsDirectional.all(16.w),
              // alignment: Alignment.center,
              child: ListView(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                children: List.generate(
                  controller.departmentList.length,
                  (index) => InkWell(
                    onTap: () {
                      if (!controller.departmentList[index].isActive) {
                        showError(body: 'هذا القسم غير متاح الان, قريبا');
                        return;
                      }
                      Get.find<DepartmentController>().setDepartmentId(
                        id: '${controller.departmentList[index].itemId}',
                      );
                      if(controller.departmentList[index].havePackage){
                        fadNavigate(
                          context,
                          AllPackagesScreen(
                            title: '${controller.departmentList[index].caption}',
                          ),
                        );
                      }else{
                        fadNavigate(
                          context,
                          DepartmentScreen(
                            title: '${controller.departmentList[index].caption}',
                          ),
                        );
                      }


                    },
                    child: Container(
                      height: 120.h,
                      width: 120.w,
                      margin: EdgeInsetsDirectional.only(top: index > 0 ? 8.h : 4.h),
                      // decoration: decorationRadius(),
                      child: PhysicalModel(
                        color: Colors.white,
                        elevation: 3,
                        borderRadius: BorderRadius.circular(10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.r),
                          child: NetImage(
                            uri: controller.departmentList[index].imagePath,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 88.h),
          ],
        ),
      ),
    );
  }
}
