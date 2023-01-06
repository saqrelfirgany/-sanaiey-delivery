// import 'package:flutter_screenutil/src/size_extension.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:sanaieydeliveryuser/controllers/MainControllers/home_controller.dart';
// import 'package:sanaieydeliveryuser/loading_widgets/home_top_banners_loading_widget.dart';
// import 'package:sanaieydeliveryuser/Screens/SharedComponents/loader.dart';
// import 'package:sanaieydeliveryuser/Screens/SharedComponents/net_image.dart';
// import 'package:sanaieydeliveryuser/Screens/bottom_navigation_bar_screens/home/bloc/home_top_banners_bloc/home_top_banners_cubit.dart';
//
// import '../../../../utils/files_export.dart';
// import '../../../bottom_navigation_bar_screens/home/bloc/home_top_banners_bloc/home_top_banners_states.dart';
//
// class HomeTopImagesSlider extends StatelessWidget {
//   const HomeTopImagesSlider({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       builder: (controller) => controller.loadingSlider
//           ? SizedBox(
//               width: width(context),
//               height: height(context) * .2,
//               child: loader,
//             )
//           : SizedBox(
//               width: width(context),
//               height: height(context) * .2,
//               child: SizedBox(
//                 width: width(context),
//                 height: height(context) * .2,
//                 child: CarouselSlider(
//                   options: CarouselOptions(
//                     viewportFraction: .8,
//                     aspectRatio: 0.1,
//                     enlargeCenterPage: true,
//                     scrollDirection: Axis.horizontal,
//                     autoPlay: true,
//                   ),
//                   items: controller.sliderList
//                       .map(
//                         (item) => Container(
//                           width: double.infinity,
//                           height: 170.h,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: NetImage(uri: item.imagePath),
//                           ),
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ),
//             ),
//     );
//   }
// }
