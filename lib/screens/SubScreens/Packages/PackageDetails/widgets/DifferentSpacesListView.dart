// import 'package:flutter/material.dart';
// import 'package:sanaiey/utils/responsive.dart';
//
// import 'SingleSpaceDescriptionCard.dart';
//
// class DifferentSpacesListView extends StatelessWidget {
//   const DifferentSpacesListView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: isLandscape(context)
//             ? 2 * height(context) * .48
//             : height(context) * .48,
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             return SingleSpaceDescriptionCard();
//           },
//           itemCount: 7,
//           scrollDirection: Axis.vertical,
//         ));
//   }
// }
