import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/address_model.dart';
import 'package:sanaiey/Models/SubModel/phone_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/SharedComponents/AppBar/profile_app_bar.dart';
import 'package:sanaiey/screens/SharedComponents/loader.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/reload.dart';
import 'package:sanaiey/screens/SharedComponents/loaders/screen_loader.dart';
import 'package:sanaiey/screens/SubScreens/AddAddress/add_address_screen.dart';

import 'body/address_item.dart';
import 'body/profile_dialog.dart';
import 'body/profile_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.isReverse = false}) : super(key: key);
  final bool isReverse;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserController userController;
  int phoneIndex = -1;

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    getData();
    phoneIndex = -1;
  }

  Future<void> getData() async {
    userController.phoneController.clear();
    await userController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      extendBody: true,
      appBar: ProfileAppBar2(context: context, title: 'البيانات الشخصية'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: widget.isReverse,
        child: GetBuilder<UserController>(
          builder: (userController) => userController.userStage == UserStage.LOADING
              ? Center(child: const ScreenLoader())
              : Reload(
                  load: () async {
                    await getData();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ProfileItem(
                          title: 'الاسم',
                          value: '${userController.userInfo.clientName}',
                          press: () => ProfileDialog(
                            context: context,
                            controller: userController.nameController,
                            press: () => userController.updateClientName(),
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ProfileItem(
                          title: 'البريد الإلكتروني',
                          value: '${userController.userInfo.clientEmail}',
                          press: () => ProfileDialog(
                            context: context,
                            controller: userController.emailController,
                            press: () => userController.updateClientEmail(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ارقام الهاتف',
                              style: titleNormal(color: Colors.black, size: 18),
                            ),
                            InkWell(
                              onTap: () {
                                Get.find<UserController>().setPhone(phone: PhoneModel());
                                ProfileDialog(
                                  context: context,
                                  controller: userController.phoneController,
                                  press: () => userController.addPhone(),
                                  title: 'اضافة رقم',
                                  textInputType: TextInputType.number,
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
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          // height: 220.h,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: userController.phoneList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              // return PhoneItem(phone: userController.phoneList[index]);
                              return Container(
                                width: double.infinity,
                                decoration: decorationDoubleRadiusBorder(),
                                padding: EdgeInsets.all(16.w),
                                margin: EdgeInsetsDirectional.only(bottom: 8.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(CupertinoIcons.phone),
                                            SizedBox(width: 8.w),
                                            SizedBox(
                                              width: 240.w,
                                              child: Text(
                                                '${userController.phoneList[index].clientPhone}',
                                                style: titleNormal(color: Colors.black),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        GetBuilder<UserController>(
                                          builder: (userController) =>
                                              userController.loading && phoneIndex == index
                                                  ? loader
                                                  : GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          phoneIndex = index;
                                                        });
                                                        Get.find<UserController>().deletePhone(
                                                          id: '${userController.phoneList[index].clientPhoneId}',
                                                        );
                                                      },
                                                      child: const Icon(CupertinoIcons.delete),
                                                    ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.find<UserController>()
                                                .setPhone(phone: userController.phoneList[index]);
                                            ProfileDialog(
                                              context: context,
                                              controller: Get.find<UserController>().phoneController,
                                              press: () => Get.find<UserController>().updatePhone(),
                                              title: 'تعديل',
                                              textInputType: TextInputType.number,
                                            );
                                          },
                                          child: Text(
                                            'تعديل',
                                            style: titleNormal(color: mainColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Divider(thickness: 1, color: mainColor),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'العناوين',
                              style: titleNormal(color: Colors.black, size: 18),
                            ),
                            InkWell(
                              onTap: () {
                                userController.setAddress(address: AddressModel());
                                fadNavigate(context, AddAddressScreen(edit: false));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'اضافة عنوان جديد',
                                    style: titleNormal(color: Colors.black, size: 16),
                                  ),
                                  SizedBox(width: 6.w),
                                  const Icon(CupertinoIcons.add_circled)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SizedBox(
                          // height: 300.h,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: userController.addressList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return AddressItem(address: userController.addressList[index]);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
