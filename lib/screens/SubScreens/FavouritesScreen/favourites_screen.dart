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
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/service_provider_details/service_provider_details_screen.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/main_loader.dart';
import 'package:sanaiey/screens/SharedComponents/net_image.dart';

import '../../SharedComponents/BottomNavBar/quantity_and_services_nav_bar.dart';
import '../../SharedComponents/Buttons/fav_button.dart';
import 'body/fav_product_item.dart';
import 'body/fav_service_item.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List images = [
    "https://i.pinimg.com/564x/e0/bc/35/e0bc3581628f71bb1e208ae8fdab8c3c.jpg",
    "https://i.pinimg.com/236x/72/f6/99/72f69901774a7f2b47807188adf483da.jpg",
    "https://i.pinimg.com/236x/41/d4/7c/41d47c74e3342dc0df363679903ce831.jpg",
    "https://i.pinimg.com/236x/91/60/0f/91600f27b55ef46aec05b58cd4275b74.jpg",
    "https://i.pinimg.com/564x/7d/6a/fe/7d6afe069fbdfd8286b8c8a053f23775.jpg"
        "https://i.pinimg.com/236x/02/a9/9b/02a99b00b8571c7276aa7665e329bb06.jpg",
    "https://i.pinimg.com/564x/7d/6a/fe/7d6afe069fbdfd8286b8c8a053f23775.jpg"
        "https://i.pinimg.com/564x/7d/6a/fe/7d6afe069fbdfd8286b8c8a053f23775.jpg",
    "https://i.pinimg.com/236x/9e/a4/91/9ea491b70eadf281a2ec11421340f9c1.jpg"
  ];
  bool services = true;
  bool serviceProviders = false;
  bool products = false;
  late FavController favController;
  late CartController cartController;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await Get.find<FavController>().getData();
    favController = await Get.find<FavController>();
    cartController = await Get.find<CartController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      drawer: CustomCategoryDrawer(),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            BackAppBar(title: 'المفضلة'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 660.h,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FavButton(
                          onTapButton: () {
                            setState(() {
                              services = true;
                              serviceProviders = false;
                              products = false;
                            });
                            favController.getFavList();
                          },
                          buttonText: "الخدمات",
                          isActive: services,
                        ),
                        FavButton(
                          onTapButton: () {
                            setState(() {
                              serviceProviders = true;
                              services = false;
                              products = false;
                            });
                            favController.getFavEmployeeList();
                          },
                          buttonText: "مقدمي الخدمات",
                          isActive: serviceProviders,
                        ),
                        FavButton(
                          onTapButton: () {
                            setState(() {
                              products = true;
                              services = false;
                              serviceProviders = false;
                            });
                          },
                          buttonText: "المنتجات",
                          isActive: products,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    services == true
                        ? GetBuilder<FavController>(
                            builder: (controller) => controller.favStage == FavStage.LOADING
                                ? SizedBox(
                                    width: double.infinity,
                                    // height: 400.h,
                                    child: const MainLoader(),
                                  )
                                : SizedBox(
                                    height: 545.h,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 60.h),
                                      children: List.generate(
                                        controller.favList.length,
                                        (index) => FavServiceItem(
                                          item: controller.favList[index],
                                          index: index,
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        : Container(),
                    serviceProviders
                        ? GetBuilder<FavController>(
                            builder: (controller) => controller.favStage == FavStage.LOADING
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 400.h,
                                    child: const MainLoader(),
                                  )
                                : SizedBox(
                                    height: 545.h,
                                    child: ListView(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.only(bottom: 60.h),
                                      physics: const BouncingScrollPhysics(),
                                      children: List.generate(
                                        controller.favEmployeeList.length,
                                        (index) => Padding(
                                          padding: EdgeInsets.all(8.w),
                                          child: PhysicalModel(
                                            color: Colors.white,
                                            elevation: 3,
                                            borderRadius: BorderRadius.circular(10),
                                            child: InkWell(
                                              onTap: () {
                                                Get.find<OrderController>().setEmployeeID(
                                                  id: '${controller.favEmployeeList[index].id}',
                                                );
                                                fadNavigate(context, ServiceProviderDetailsScreen());
                                              },
                                              child: Container(
                                                height: 120.h,
                                                width: 370.w,
                                                decoration: decorationRadius(
                                                  color: backGroundColor,
                                                ),
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    '${controller.favEmployeeList[index].name}',
                                                                    style: titleBold(
                                                                        color: Colors.black, size: 14),
                                                                  ),
                                                                  Text(
                                                                    '${controller.favEmployeeList[index].title}',
                                                                    style: titleNormal(
                                                                        color: Colors.black, size: 12),
                                                                  ),
                                                                  SizedBox(height: 8.h),
                                                                  AbsorbPointer(
                                                                    absorbing: true,
                                                                    child: RatingBar(
                                                                      initialRating: double.parse(
                                                                          '${controller.favEmployeeList[index].rate}'),
                                                                      direction: Axis.horizontal,
                                                                      allowHalfRating: true,
                                                                      itemCount: 5,
                                                                      itemSize: 20.w,
                                                                      ratingWidget: RatingWidget(
                                                                        full: Icon(Icons.star_rounded,
                                                                            color: Colors.red.shade900),
                                                                        half: Icon(Icons.star_rounded,
                                                                            color: Colors.red.shade900),
                                                                        empty: Icon(
                                                                            Icons.star_border_rounded,
                                                                            color: Colors.red.shade900),
                                                                      ),
                                                                      itemPadding: EdgeInsets.symmetric(
                                                                          horizontal: 4.0),
                                                                      onRatingUpdate: (rating) {
                                                                        print(rating);
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Spacer(),
                                                              Container(
                                                                width: 90.w,
                                                                height: 90.w,
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(28.r),
                                                                ),
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(28.r),
                                                                  child: NetImage(
                                                                    uri:
                                                                        'http://${controller.favEmployeeList[index].image}',
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        favController.addEmployeeToFav(
                                                          employeeId:
                                                              '${controller.favEmployeeList[index].id}',
                                                        );
                                                        favController.removeFromFavEmployeeList(
                                                          index: index,
                                                        );
                                                      },
                                                      child: Icon(
                                                        CupertinoIcons.heart_fill,
                                                        color: Colors.red.shade900,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          )
                        : Container(),
                    products
                        ? GetBuilder<FavController>(
                            builder: (controller) => controller.favStage == FavStage.LOADING
                                ? SizedBox(
                                    width: double.infinity,
                                    height: 400.h,
                                    child: const MainLoader(),
                                  )
                                : SizedBox(
                                    height: 480.h,
                                    // width: 340.w,
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.only(bottom: 60.h),
                                      children: List.generate(
                                        providerList.length,
                                        (index) => FavProductItem(),
                                      ),
                                    ),
                                  ),
                          )
                        : Container(),
                    // SizedBox(height: 80.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomNavBar(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: QuantityAndServicesNavBar(),
    );
  }
}
