import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/SubModel/address_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';

class AppBarAddressItem extends StatefulWidget {
  const AppBarAddressItem({Key? key, required this.address}) : super(key: key);
  final AddressModel address;

  @override
  State<AppBarAddressItem> createState() => _AppBarAddressItemState();
}

class _AppBarAddressItemState extends State<AppBarAddressItem> {
  bool _isUpdating = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: Get.find<UserController>(),
      builder: (userController) => InkWell(
        onTap: () {
          setState(() {
            _isUpdating = true;
          });
          userController.changeAddress(changeAddress: widget.address);
          userController.updateDefaultAddress(popFlag: true).then((value) {
            setState(() {
              _isUpdating = false;
            });
          });
        },
        child: Container(
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
                          : Container(
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 8.w),
                          Container(
                            width: 300.w,
                            child: Text(
                              '${widget.address.addressGov} - '
                              '${widget.address.addressCity} - '
                              '${widget.address.addressRegion}',
                              style: titleNormal(color: Colors.black),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 8.w),
                          Container(
                            width: 300.w,
                            child: Text(
                              '${widget.address.addressStreet} - '
                              '${widget.address.addressDes}',
                              style: titleNormal(color: const Color(0xFF949494), size: 14),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
