import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/phone_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/MainScreens/SettingsDrawer/settings_drawer.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/back_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SubScreens/EditAddress/edit_address.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/body/profile_dialog.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/profile_screen.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/NewSubscriptionsDate/new_subscription_date.dart';
import 'package:sanaiey/screens/SubscriptionsScreens/UserSubscriptionsDateScreen/user_subscriptions_date_screen.dart';

class SubscriptionsAddress extends StatefulWidget {
  const SubscriptionsAddress({Key? key}) : super(key: key);

  @override
  _SubscriptionsAddressState createState() => _SubscriptionsAddressState();
}

class _SubscriptionsAddressState extends State<SubscriptionsAddress> {
  late UserController userController;
  int phoneIndex = -1;
  int _mobileIndex = -1;
  int _addressIndex = -1;
  bool _addressFlag = false;
  late OrderController orderController;
  late SubscriptionsController subscriptionsController;

  @override
  void initState() {
    super.initState();
    getData();
    phoneIndex = -1;
    getDefaultData();
  }

  Future<void> getData() async {
    userController = Get.find<UserController>();
    orderController = Get.find<OrderController>();
    subscriptionsController = Get.find<SubscriptionsController>();
    await userController.getUserAddressAndPhone();
  }

  void getDefaultData() {
    _mobileIndex = -1;
    _addressIndex = -1;
    if (userController.addressList[0].isDefault ?? false) {
      _addressIndex = 0;
      orderController.setAddressId(id: '${userController.addressList[0].addressId}');
      orderController.setCityId(id: '${userController.addressList[0].cityId}');
    }
    for (var element in userController.addressList) {
      if (element.isDefault ?? false) {
        orderController.setAddressId(id: '${userController.addressList[_addressIndex].addressId}');
        orderController.setCityId(id: '${userController.addressList[_addressIndex].cityId}');
        break;
      }
      _addressIndex++;
    }
    if (userController.phoneList[0].isDefault ?? false) {
      orderController.setPhoneId(id: '${userController.phoneList[0].clientPhoneId}');
      _mobileIndex = 0;
    }
    for (var element in userController.phoneList) {
      if (element.isDefault ?? false) {
        orderController.setPhoneId(id: '${userController.phoneList[_mobileIndex].clientPhoneId}');
        break;
      }
      _mobileIndex++;
    }
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
            BackAppBar(title: 'اختيار البيانات'),
            SizedBox(height: 8.h),
            Container(
              width: 414.w,
              height: 660.h,
              child: GetBuilder<UserController>(
                builder: (userController) => userController.AddressAndPhone == UserStage.LOADING
                    ? ScreenLoader()
                    : Reload(
                        load: () async {
                          await getData();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'العناوين',
                                      style: titleNormal(color: Colors.black, size: 18),
                                    ),
                                    InkWell(
                                      onTap: () => fadNavigate(context, ProfileScreen(isReverse: true)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'اضافة عنوان',
                                            style: titleNormal(color: Colors.black, size: 16),
                                          ),
                                          SizedBox(width: 6.w),
                                          const Icon(CupertinoIcons.arrow_left_circle)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),

                                ///
                                /// Address List
                                ///
                                AddressList(userController),
                                SizedBox(height: 24.h),
                                Divider(thickness: 2, color: mainColor),
                                SizedBox(height: 24.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'ارقام الهاتف',
                                      style: titleNormal(color: Colors.black),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.find<UserController>().setPhone(phone: PhoneModel());
                                        ProfileDialog(
                                          context: context,
                                          controller: userController.phoneController,
                                          press: () => userController.addPhone(),
                                          title: 'اضافة رقم',
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'اضافة رقم جديد',
                                            style: titleNormal(color: Colors.black, size: 16),
                                          ),
                                          SizedBox(width: 6.w),
                                          const Icon(CupertinoIcons.add_circled)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.h),

                                ///
                                /// Phone List
                                ///
                                phoneList(userController),
                                SizedBox(height: 16.h),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (_addressIndex == -1) {
            showError(body: 'برجاء تحديد الماكان');
            return;
          }
          if (_mobileIndex == -1) {
            showError(body: 'برجاء اختيار رقم الهاتف');
            return;
          }
          if (subscriptionsController.userSubscriptionFlag) {
            fadNavigate(context, UserSubscriptionsDateScreen());
          } else {
            fadNavigate(context, NewSubscriptionsDateScreen());
          }
        },
        child: Container(
          width: double.infinity,
          height: 50.h,
          margin: EdgeInsets.all(16.w),
          decoration: decorationRadius().copyWith(
            color: const Color(0xFFAE0910),
          ),
          child: Center(
            child: Text(
              'متابعة الطلب',
              style: titleNormal(color: Colors.white, size: 18),
            ),
          ),
        ),
      ),
    );
  }

  SizedBox AddressList(UserController userController) {
    return SizedBox(
      // height: 300.h,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: userController.addressList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _addressIndex = index;
                      _addressFlag = true;
                    });
                    orderController.setAddressId(id: '${userController.addressList[index].addressId}');
                    orderController.setCityId(id: '${userController.addressList[index].cityId}');
                    setState(() {
                      _addressFlag = false;
                    });
                  },
                  child: Container(
                    height: 68.h,
                    width: double.infinity,
                    decoration: decorationDoubleRadiusBorder(
                      color: _addressIndex == index ? mainColor : Color(0xFFDFDFDF),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    margin: EdgeInsetsDirectional.only(bottom: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(CupertinoIcons.location),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  // color: Colors.blue,
                                  width: 230.w,
                                  margin: EdgeInsetsDirectional.only(start: 8.w),
                                  child: Text(
                                    '${userController.addressList[index].addressGov} - '
                                    '${userController.addressList[index].addressCity} - '
                                    '${userController.addressList[index].addressRegion}',
                                    style: titleNormal(color: Colors.black),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  // color: Colors.blue,
                                  width: 230.w,
                                  margin: EdgeInsetsDirectional.only(start: 8.w),
                                  child: Text(
                                    '${userController.addressList[index].addressDes ?? ''}',
                                    style: titleNormal(color: Colors.grey.shade800, size: 14),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            userController.loading && _addressIndex == index
                                ? SizedBox(
                                    width: 32.w,
                                    height: 32.w,
                                    child: Center(
                                      child: SpinKitCircle(
                                        size: 28.w,
                                        color: const Color(0xFFAE0910),
                                      ),
                                    ),
                                  )
                                : _addressIndex == index
                                    ? Container(
                                        width: 22.w,
                                        height: 22.w,
                                        // padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: mainColor,
                                          border: Border.all(width: 1, color: mainColor),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/icons/location.png',
                                            width: 10.w,
                                            height: 10.w,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        width: 22.w,
                                        height: 22.w,
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          // color: Colors.grey,
                                          border: Border.all(width: 1, color: mainColor),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: GestureDetector(
                    onTap: () {
                      Get.find<UserController>().setAddress(address: userController.addressList[index]);
                      fadNavigate(context, EditAddressScreen(address: userController.addressList[index]));
                    },
                    child: Container(
                      height: 68.h,
                      decoration: decorationDoubleRadiusBorder(
                        radius: 16,
                        color: _addressIndex == index ? mainColor : Color(0xFFDFDFDF),
                      ),
                      child: Icon(Icons.edit, size: 18),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  SizedBox phoneList(UserController userController) {
    return SizedBox(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: userController.phoneList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _mobileIndex = index;
              });
              orderController.setPhoneId(id: '${userController.phoneList[index].clientPhoneId}');
            },
            child: Container(
              width: double.infinity,
              height: 48.h,
              decoration: decorationDoubleRadiusBorder(
                color: _mobileIndex == index ? mainColor : Color(0xFFDFDFDF),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsetsDirectional.only(bottom: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(CupertinoIcons.phone),
                          SizedBox(width: 8.w),
                          Text(
                            '${userController.phoneList[index].clientPhone}',
                            style: titleNormal(color: Colors.black),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      _mobileIndex == index
                          ? Container(
                              width: 22.w,
                              height: 22.w,
                              // padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: mainColor,
                                border: Border.all(width: 1, color: mainColor),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 12.w,
                                ),
                              ),
                            )
                          : Container(
                              width: 22.w,
                              height: 22.w,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                border: Border.all(width: 1, color: mainColor),
                                shape: BoxShape.circle,
                              ),
                            ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
