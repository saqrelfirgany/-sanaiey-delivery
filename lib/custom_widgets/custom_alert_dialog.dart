// import 'package:sanaieydeliveryuser/utils/files_export.dart';
//
// Future showCustomAlertDialog(
//     {BuildContext? context,
//     bool withSecondTitle = false,
//     String secondTitle = "",
//     Widget icon = const Icon(Icons.close),
//     Color circleColor = mainColor,
//     String alertTitle = '',
//     String alertSubtitle = '',
//     bool withTwoButtons = false,
//     int maxLines = 2,
//     String secondButtoText = "",
//     VoidCallback? onTapSecondButton}) {
//   return showDialog<void>(
//     context: context!,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         backgroundColor: whiteColor,
//         content: SizedBox(
//           width: isLandscape(context)
//               ? .7 * width(context) * .85
//               : width(context) * .85,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const CustomSizedBox(percentageOfHeight: .02),
//               const CustomSizedBox(percentageOfHeight: .02),
//               CustomText(
//                   text: translator.translate(alertTitle),
//                   percentageOfHeight: .03,
//                   textColor: whiteColor,
//                   fontWeight: FontWeight.bold),
//               CustomSizedBox(
//                   percentageOfHeight: withSecondTitle == true ? .01 : 0.0),
//               withSecondTitle == true
//                   ? CustomText(
//                       text: translator.translate(secondTitle),
//                       textColor: whiteColor,
//                       percentageOfHeight: .02,
//                       maxLines: maxLines)
//                   : SizedBox(),
//               CustomSizedBox(percentageOfHeight: .02),
//               CustomText(
//                   text: translator.translate(alertSubtitle),
//                   percentageOfHeight: .02,
//                   textColor: mainColor,
//                   maxLines: maxLines)
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           Container(
//             padding: EdgeInsets.all(
//               height(context) * .02,
//             ),
//             child: Row(
//               children: [
//                 Container(
//                   child: withTwoButtons == true
//                       ? GestureDetector(
//                           child: CustomText(
//                               text: secondButtoText,
//                               textColor: mainColor,
//                               percentageOfHeight: .025,
//                               fontWeight: FontWeight.bold),
//                           onTap: onTapSecondButton)
//                       : SizedBox(),
//                 ),
//                 SizedBox(
//                   width: width(context) * .05,
//                 ),
//                 GestureDetector(
//                   child: CustomText(
//                       text: "ok",
//                       textColor: mainColor,
//                       percentageOfHeight: .023),
//                   onTap: () {
//                     Navigator.of(context).pop();
// //                    customPushNamedNavigation(context, HomeScreen());
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
