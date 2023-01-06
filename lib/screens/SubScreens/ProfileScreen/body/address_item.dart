import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/Models/SubModel/address_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/SubScreens/EditAddress/edit_address.dart';

class AddressItem extends StatefulWidget {
  const AddressItem({Key? key, required this.address}) : super(key: key);
  final AddressModel address;

  @override
  State<AddressItem> createState() => _AddressItemState();
}

class _AddressItemState extends State<AddressItem> {
  bool _isUpdating = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: Get.find<UserController>(),
      builder: (userController) => Container(
        width: double.infinity,
        decoration: decorationDoubleRadiusBorder(),
        padding: EdgeInsets.all(16.w),
        margin: EdgeInsetsDirectional.only(bottom: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.address.isDefault
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
                    : _isUpdating
                        ? Container(
                            width: 22.w,
                            height: 22.w,
                            child: Center(
                              child: SpinKitCircle(
                                size: 18.w,
                                color: const Color(0xFFAE0910),
                              ),
                            ),
                          )
                        : InkWell(
                            onTap: () {
                              setState(() {
                                _isUpdating = true;
                              });
                              userController.changeAddress(changeAddress: widget.address);
                              userController.updateDefaultAddress(popFlag: false).then((value) {
                                setState(() {
                                  _isUpdating = false;
                                });
                              });
                            },
                            child: Container(
                              width: 22.w,
                              height: 22.w,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                // color: Colors.grey,
                                border: Border.all(width: 1, color: mainColor),
                                shape: BoxShape.circle,
                              ),
                              // child: const Icon(CupertinoIcons.location),
                            ),
                          ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 8.w),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isUpdating = true;
                            });
                            userController.changeAddress(changeAddress: widget.address);
                            userController.updateDefaultAddress(popFlag: false).then((value) {
                              setState(() {
                                _isUpdating = false;
                              });
                            });
                          },
                          child: Container(
                            // color: Colors.red,
                            width: 268.w,
                            child: Text(
                              '${widget.address.addressGov} - '
                              '${widget.address.addressCity} - '
                              '${widget.address.addressRegion}',
                              style: titleNormal(color: Colors.black),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        _isDeleting
                            ? Container(
                                width: 30.w,
                                height: 30.w,
                                child: Center(
                                  child: SpinKitCircle(
                                    size: 26.w,
                                    color: const Color(0xFFAE0910),
                                  ),
                                ),
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    _isDeleting = true;
                                  });
                                  userController.deleteAddress(id: '${widget.address.addressId}').then(
                                    (value) {
                                      setState(() {
                                        _isDeleting = false;
                                      });
                                    },
                                  );
                                },
                                child: const Icon(CupertinoIcons.delete),
                              ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isUpdating = true;
                        });
                        userController.changeAddress(changeAddress: widget.address);
                        userController.updateDefaultAddress(popFlag: false).then((value) {
                          setState(() {
                            _isUpdating = false;
                          });
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 8.w),
                          Container(
                            // color: Colors.blue,
                            width: 268.w,
                            // height: 40.h,
                            child: Text(
                              '${widget.address.addressStreet} - '
                              '${widget.address.addressDes}',
                              style: titleNormal(color: const Color(0xFF949494), size: 15),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //       _isUpdating = true;
                //     });
                //     userController.changeAddress(changeAddress: widget.address);
                //     userController.updateDefaultAddress(popFlag: false).then((value) {
                //       setState(() {
                //         _isUpdating = false;
                //       });
                //     });
                //   },
                //   child: Container(
                //     width: 290.w,
                //     height: 30.h,
                //     color: Colors.grey,
                //   ),
                // ),
                // Spacer(),
                InkWell(
                  onTap: () {
                    Get.find<UserController>().setAddress(address: widget.address);
                    fadNavigate(context, EditAddressScreen(address: widget.address));
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
      ),
    );
  }
}
