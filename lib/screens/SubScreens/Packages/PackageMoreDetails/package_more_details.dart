import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:sanaiey/Helper/decoration_helper.dart';
import 'package:sanaiey/Helper/fonts_helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/screens/MainScreens/DepartmentScreen/body/department_hearder.dart';

import '../../../SharedComponents/AppBar/back_app_bar.dart';
import 'widgets/service_top_immage.dart';
import 'widgets/subscription_details.dart';

class PackageMoreDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        extendBody: true,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              BackAppBar(title: 'خدمات النظافة'),
              // SizedBox(height: 40),
              Container(
                width: 414.w,
                height: 600.h,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 100.h),
                      DepartmentHeader(text: 'خدمات النظافة المنزلية'),
                      SizedBox(height: 16.h),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 60.h,
                                  width: 60.w,
                                  child: Image.asset('assets/icons/normal_cleaning.png'),
                                ),
                                Text(
                                  'زيارة شهريا مساحة منزل من 80 الي 120 متر',
                                  style: titleBold(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: SizedBox(
                              width: 414.w,
                              child: Text(
                                'لعرض يشمل: * تنظيف 7 '
                                'وحدات (3 غرف + قطعتين ريسيبشن + حمام + مطبخ) حتى 150 متر * '
                                'الحمامات غسيل الحمامات ، المراحيض – الاحواض – الارضيات *'
                                ' المطبخ تنظيف الارضيات – البوتجاز – الأحواض- الثلاجه-غسيل الاطباق'
                                '( حالات العزومات و الحفلات تكون بتكلفه اضافيه) * تنظيف الشفاطات بدون '
                                'استخدام مواد كاويه (لعدم تعريض العامل للخطوره) * تنظيف السجاد'
                                ' بالمكنسة الكهربائيه و نظافه اسفل السجاد * كنس ومسح كل'
                                ' الارضيات * تلميع جميع الطاولات بالمنظف الخاص بها وما يوفره'
                                ' العميل ، وتلميع الأنتيكات * تلميع الاثاث من الخارج. * الشبابيك'
                                ' تنظيف الشبابيك والزجاج من الأتربة والمياه من الداخل والخارح'
                                ' فى متناول اليد (حتي لا يتعرض العامل لخطر السقوط ) * تنظيف'
                                ' الثلاجة من الداخل والخارج ويجب تفريغ محتويات التلاجة وإعادتها'
                                ' بواسطة العميل حفاظا على نظافتكم * تحت الاثاث * البلكونات'
                                ' * غسيل النجف. * تنزيل كل محتويات المطبخ وتنظيف الدرف من ا'
                                'لداخل والخارج (تنزيل الدرف و اعادة رص محتويات المطبخ يكون '
                                'بواسطة العميل للأمان والنظافة العامة) * غسيل المشايات الصغيرة'
                                ' لا يشمل العرض: × غسيل السجاد والمفروشات و الستائر بالمنظفات'
                                ' (راجع عرض نظافه المفروشات المنفصل). × تنزيل كل محتويات النيش و تلميعه'
                                ' من الداخل واعاده رص محتوياته. ملاحظات: - يوفر العميل الادوات'
                                ' و المنظفات. - فى حالة وجود حمام ضيوف (صغير) تظل التكلفة'
                                ' كما هى - فى حالة زيادة قطعة زيادة (غرفة) يضاف 50 جنيه. '
                                '- يرجي الاتصال للحجز مبكرا نظرا للاقبال علي الخدمة.',
                                style: titleNormal(color: Colors.black),
                                maxLines: 20,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 120.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar:InkWell(
          onTap: (){},
          child: Container(
            width: 120.w,
            height: 60.h,
            margin: EdgeInsets.all(16.w),
            decoration: decorationRadius().copyWith(
              color: const Color(0xFFAE0910),
            ),
            child: Center(
              child: Text(
                'أشترك واحجز الاوردر',
                style: titleNormal(color: Colors.white, size: 18),
              ),
            ),
          ),
        ),
      ),
    );
  }
}