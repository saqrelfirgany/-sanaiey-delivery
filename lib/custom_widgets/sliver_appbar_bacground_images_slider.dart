
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/utils/check_direction.dart';
import 'package:sanaiey/utils/responsive.dart';

sliverAppBarBackgroundWiImagesSlider(
    {BuildContext? context,
    List? imagesSliderList,
    isContainBackButton: true}) {
  return SizedBox(
      width: width(context!),
      height: isLandscape(context)
          ? 2 * height(context) * .4
          : 2 * height(context) * .4,
      child: Stack(
        children: [
          SizedBox(
            width: width(context),
            height: isLandscape(context)
                ? 2 * height(context) * .4
                : height(context) * .4,
            child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 0.1,
                enlargeCenterPage: false,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
              ),
              items: imagesSliderList!
                  .map((item) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(item), fit: BoxFit.cover)),
                      ))
                  .toList(),
            ),
          ),
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: isLandscape(context)
                        ? 2 * height(context) * .03
                        : 2 * height(context) * .03,
                    left: width(context) * .05,
                    right: width(context) * .05),
                width: width(context),
                child: isContainBackButton == true
                    ? GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                        ))
                    : SizedBox(),
                alignment: checkDirection(
                    dirEnglish: Alignment.topLeft,
                    dirArabic: Alignment.topRight),
              ),
            ],
          ),
        ],
      ));
}
