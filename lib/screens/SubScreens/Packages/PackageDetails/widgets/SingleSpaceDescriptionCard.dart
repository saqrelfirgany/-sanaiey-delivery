//
// import 'package:flutter/material.dart';
// import 'package:flutter_neumorphic/flutter_neumorphic.dart';
// import 'package:sanaiey/Helper/route.dart';
// import 'package:sanaiey/constants/colors.dart';
// import 'package:sanaiey/constants/font_sizes.dart';
// import 'package:sanaiey/constants/spacing_and_sizes.dart';
// import 'package:sanaiey/custom_widgets/custom_icon_button.dart';
// import 'package:sanaiey/custom_widgets/custom_sized_box.dart';
// import 'package:sanaiey/custom_widgets/custom_text.dart';
// import 'package:sanaiey/screens/SubScreens/Packages/SubPackageScreen/sub_package_screen.dart';
// import 'package:sanaiey/utils/responsive.dart';
//
// class SingleSpaceDescriptionCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             fadNavigate(context,SubPackageScreen());
//           },
//           child: Container(
//             margin: EdgeInsets.only(
//                 bottom: height(context) * listViewVerticalSpacing),
//             child: Neumorphic(
//               style: NeumorphicStyle(color: whiteColor),
//               child: Column(
//                 children: [
//                   CustomSizedBox(
//                     percentageOfHeight: .02,
//                   ),
//                   Container(
//                     width: width(context) * .9,
//                     color: whiteColor,
//                     padding: EdgeInsets.only(
//                         right: width(context) * defaultCardPadding,
//                         left: width(context) * defaultCardPadding),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
// //                      width: width(context)*.48,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               CustomSizedBox(percentageOfHeight: .005),
//                               Container(
//                                 width: width(context) * .7,
//                                 child: CustomText(
//                                     text: "2 مساحة منزل من 80 الي 120 متر  ",
//                                     textAlign: TextAlign.start,
//                                     maxLines: 3,
//                                     fontWeight: FontWeight.bold,
//                                     percentageOfHeight: defaultFontSize),
//                               ),
//                               CustomSizedBox(
//                                 percentageOfHeight: .01,
//                               ),
//                               Container(
//                                 width: width(context) * .7,
//                                 child: CustomText(
//                                     text: "شقة 2 غرفة نوم",
//                                     maxLines: 2,
//                                     textAlign: TextAlign.start),
//                               )
//                             ],
//                           ),
//                         ),
//                         CustomIconButton(
//                             icon: Icons.arrow_forward_ios,
//                             color: blackColor,
//                             size: .03)
//                       ],
//                     ),
//                   ),
//                   CustomSizedBox(
//                     percentageOfHeight: .02,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
