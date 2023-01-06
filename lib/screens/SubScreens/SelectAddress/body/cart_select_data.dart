import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/phone_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/screens/SharedComponents/getsnack_bars.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SubScreens/ChooseDateScreen/time_screen.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/body/profile_dialog.dart';
import 'package:sanaiey/screens/SubScreens/ProfileScreen/profile_screen.dart';

class CartSelectData extends StatefulWidget {
  const CartSelectData({Key? key}) : super(key: key);

  @override
  State<CartSelectData> createState() => _CartSelectDataState();
}

class _CartSelectDataState extends State<CartSelectData> {
  int _mobileIndex = -1;
  int _addressIndex = -1;
  late UserController _userController;

  @override
  void initState() {
    super.initState();
    _mobileIndex = -1;
    _addressIndex = -1;
    _userController = Get.find<UserController>();
    if (_userController.addressList[0].isDefault ?? false) {
      _addressIndex = 0;
      print('_addressIndex$_addressIndex');
    }
    for (var element in _userController.addressList ) {
      if (element.isDefault ?? false) {
        break;
      }
      _addressIndex++;
      print('_addressIndex$_addressIndex');
    }
    if (_userController.phoneList[0].isDefault ?? false) {
      _mobileIndex = 0;
      print('mobile index$_mobileIndex');
    }
    for (var element in _userController.phoneList) {
      if (element.isDefault ?? false) {
        break;
      }
      _mobileIndex++;
      print('mobile index$_mobileIndex');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (userController) => userController.userStage == UserStage.LOADING
          ? const ScreenLoader()
          : Container(
              padding: EdgeInsets.all(16.w),
              margin: EdgeInsets.only(bottom: 120.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'العناوين',
                        style: titleNormal(color: Colors.black, size: 18),
                      ),
                      InkWell(
                        onTap: () {
                          fadNavigate(context, ProfileScreen(isReverse: true));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'عناويني',
                              style: titleNormal(color: Colors.black, size: 16),
                            ),
                            SizedBox(width: 6.w),
                            const Icon(CupertinoIcons.arrow_left_circle)
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    // height: 300.h,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: userController.addressList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _addressIndex = index;
                            });
                            print('saqr ${userController.addressList[index].latitude}');
                            print('saqr ${userController.addressList[index].longitude}');
                          },
                          child: Container(
                            width: double.infinity,
                            height: 68.h,
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
                                          width: 280.w,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 8.w),
                                              Text(
                                                '${userController.addressList[index].addressGov} - '
                                                '${userController.addressList[index].addressCity} - '
                                                '${userController.addressList[index].addressRegion}',
                                                style: titleNormal(color: Colors.black),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.blue,
                                          width: 280.w,
                                          child: Row(
                                            children: [
                                              SizedBox(width: 8.w),
                                              Text(
                                                '${userController.addressList[index].addressDes ?? ''}',
                                                style: titleNormal(color: Colors.grey.shade800, size: 14),
                                                maxLines: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    _addressIndex == index
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
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Divider(thickness: 2, color: mainColor),
                  SizedBox(height: 8.h),
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
                  SizedBox(height: 8.h),
                  SizedBox(
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: userController.phoneList.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _mobileIndex = index;
                            });
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
                  ),
                  SizedBox(height: 16.h),
                  InkWell(
                    onTap: () {
                      if (_addressIndex == -1) {
                        showError(body: 'برجاء تحديد الماكان');
                        return;
                      }
                      if (_mobileIndex == -1) {
                        showError(body: 'برجاء اختيار رقم الهاتف');
                        return;
                      }

                      fadNavigate(context, TimeScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      margin: EdgeInsets.all(8.w),
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
                  const CustomSizedBox(percentageOfHeight: .02),
                  const CustomSizedBox(percentageOfHeight: .1),
                ],
              ),
            ),
    );
  }
}
