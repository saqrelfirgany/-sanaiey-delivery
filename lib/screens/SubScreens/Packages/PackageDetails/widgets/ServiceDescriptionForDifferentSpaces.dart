
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
import 'package:sanaiey/custom_widgets/custom_text.dart';
import 'package:sanaiey/utils/responsive.dart';

class ServiceDescriptionForDifferentSpaces extends StatelessWidget {
  const ServiceDescriptionForDifferentSpaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .9,
      child: Row(
        children: [
          Container(
            height: isLandscape(context) ? 2 * height * .1 : height * .1,
            width: width * .12,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/icons/normal_cleaning.png")),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  width: width * .78,
                  child: const CustomText(
                    text: "تنظيف عادي",
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                    textColor: blackColor,
                  )),
              const CustomSizedBox(
                percentageOfHeight: .01,
              ),
              SizedBox(
                  width: width * .78,
                  child: const CustomText(
                    text:
                        "خدمة النظافة المنزلية بالتعاقد مع عمالة بجودة عالية . توفر الشركة عمالة على قدر كبير من الأمانة والخبرة ، متوفر عاملات وعمال ذكر واناث",
                    textAlign: TextAlign.start,
                    maxLines: 100,
                    textColor: blackColor,
                    percentageOfHeight: .014,
                    textHeight: 1.2,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
