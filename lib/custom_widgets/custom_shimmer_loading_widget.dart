// import '../utils/files_export.dart';
//
// class CustomShimmerWidget extends StatelessWidget {
//   final double shimmerHeight;
//   final double shimmerWidth;
//   final double shimmerRadius;
//   final bool isShimmerCircled;
//   const CustomShimmerWidget(
//       {Key? key,
//       this.shimmerHeight = .1,
//       this.shimmerWidth = .2,
//       this.shimmerRadius = 0,
//       this.isShimmerCircled = false})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
//       height: height(context) * shimmerHeight,
//       width: width(context) * shimmerWidth,
//       child: Shimmer.fromColors(
//           highlightColor: backGroundColor.withOpacity(.1),
//           baseColor: backGroundColor.withOpacity(0.5),
//           direction: ShimmerDirection.ltr,
//           child: Container(
//             decoration: isShimmerCircled
//                 ? const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: whiteColor,
//                   )
//                 : BoxDecoration(
//                     borderRadius: BorderRadius.circular(shimmerRadius),
//                     color: whiteColor,
//                   ),
//           )),
//     );
//   }
// }
