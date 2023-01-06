import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:get/get.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/Models/IntroModels/governorate_model.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/IntroControllers/select_address_controller.dart';

class GovernorateDropDown extends StatelessWidget {
  GovernorateDropDown({
    Key? key,
    required this.list,
    required this.press,
    this.margin = 24,
  }) : super(key: key);

  final List<Governorate> list;
  final double margin;
  Function({required String? item}) press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectAddressController>(
      init: Get.find<SelectAddressController>(),
      builder: (controller) => Container(
        width: double.infinity,
        height: 45.h,
        margin: EdgeInsets.symmetric(horizontal: margin.w),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: const Color(0xFFBEBEBE),
          ),
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsetsDirectional.only(
              start: 16.w,
              end: 8.w,
              bottom: 4.h,
            ),
          ),
          isDense: false,
          itemHeight: 55.h,
          dropdownColor: backGroundColor,
          iconEnabledColor: Colors.black,
          iconDisabledColor: Colors.black,
          value: list[0].governorateName,
          items: list
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.governorateName,
                  child: Text(
                    item.governorateName,
                    maxLines: 1,
                    style: titleNormal(color: const Color(0xFF949494)),
                  ),
                ),
              )
              .toList(),
          onChanged: (item) => press(item: item),
        ),
      ),
    );
  }
}
