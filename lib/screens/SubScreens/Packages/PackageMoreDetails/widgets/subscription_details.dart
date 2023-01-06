
import 'package:flutter/material.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class SubscriptionDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(right: width * .05, left: width * .05),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: isLandscape(context) ? 2 * height * .05 : height * .05,
                width: width * .1,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/icons/normal_cleaning.png")),
                ),
              ),
              Container(
                  width: width * .8,
                  child: CustomText(
                    text: "زيارة شهريا مساحة منزل من 80 الي 120 متر",
                    textAlign: TextAlign.start,
                    maxLines: 2,
                  ))
            ],
          ),
          CustomSizedBox(
            percentageOfHeight: .02,
          ),
          Container(
            height: isLandscape(context) ? 2 * height * .4 : height * .4,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: width * .9,
                    child: CustomText(
                      text:
                          "لعرض يشمل: * تنظيف 7 وحدات (3 غرف + قطعتين ريسيبشن + حمام + مطبخ) حتى 150 متر * الحمامات غسيل الحمامات ، المراحيض – الاحواض – الارضيات * المطبخ تنظيف الارضيات – البوتجاز – الأحواض- الثلاجه-غسيل الاطباق( حالات العزومات و الحفلات تكون بتكلفه اضافيه) * تنظيف الشفاطات بدون استخدام مواد كاويه (لعدم تعريض العامل للخطوره) * تنظيف السجاد بالمكنسة الكهربائيه و نظافه اسفل السجاد * كنس ومسح كل الارضيات * تلميع جميع الطاولات بالمنظف الخاص بها وما يوفره العميل ، وتلميع الأنتيكات * تلميع الاثاث من الخارج. * الشبابيك تنظيف الشبابيك والزجاج من الأتربة والمياه من الداخل والخارح فى متناول اليد (حتي لا يتعرض العامل لخطر السقوط ) * تنظيف الثلاجة من الداخل والخارج ويجب تفريغ محتويات التلاجة وإعادتها بواسطة العميل حفاظا على نظافتكم * تحت الاثاث * البلكونات * غسيل النجف. * تنزيل كل محتويات المطبخ وتنظيف الدرف من الداخل والخارج (تنزيل الدرف و اعادة رص محتويات المطبخ يكون بواسطة العميل للأمان والنظافة العامة) * غسيل المشايات الصغيرة لا يشمل العرض: × غسيل السجاد والمفروشات و الستائر بالمنظفات (راجع عرض نظافه المفروشات المنفصل). × تنزيل كل محتويات النيش و تلميعه من الداخل واعاده رص محتوياته. ملاحظات: - يوفر العميل الادوات و المنظفات. - فى حالة وجود حمام ضيوف (صغير) تظل التكلفة كما هى - فى حالة زيادة"
                          " قطعة زيادة (غرفة) يضاف 50 جنيه. - يرجي الاتصال للحجز مبكرا نظرا للاقبال علي الخدمة.",
                      maxLines: 500,
                      textAlign: TextAlign.start,
                      textHeight: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
