// import 'package:flutter_screenutil/src/size_extension.dart';
// import 'package:sanaieydeliveryuser/Screens/MainScreens/CartScreen/cart_screen.dart';
// import 'package:sanaieydeliveryuser/Screens/MainScreens/FavouritesScreen/subscriptions_screen.dart';
// import 'package:sanaieydeliveryuser/Screens/MainScreens/OrderScreens/orders/my_orders_screen.dart';
// import 'package:sanaieydeliveryuser/screens/MainScreens/HomeScreen/home_screen.dart';
// import 'package:sanaieydeliveryuser/utils/files_export.dart';
//
// import '../SettingsDrawer/settings_drawer.dart';
// import 'body/nav_icon.dart';
//
// class NavigationHome extends StatefulWidget {
//   final int index, catId;
//
//   const NavigationHome({Key? key, this.index: 0, this.catId: 0}) : super(key: key);
//
//   @override
//   _NavigationHomeState createState() => _NavigationHomeState();
// }
//
// class _NavigationHomeState extends State<NavigationHome> {
//   GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
//
//   int _selectedIndex = 0;
//   var pages = [
//     HomeScreen(),
//     MyOrdersScreen(),
//     CartScreen(),
//     FavouritesScreen(),
//     CustomCategoryDrawer(),
//   ];
//
//   whichPage() {
//     if (widget.index == null) {
//       setState(() {
//         _selectedIndex = 0;
//       });
//     } else {
//       setState(() {
//         _selectedIndex = widget.index;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     whichPage();
//     super.initState();
//   }
//
//   Widget bottomBar() {
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         Container(
//           color: mainColor,
//           height: 60.h,
//         ),
//         Container(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               NavIcon(
//                 isActive: _selectedIndex == 4,
//                 title: "المزيد",
//                 onTap: () {
//                   _drawerKey.currentState!.openDrawer();
//                 },
//                 iconData: "assets/icons/more.png",
//               ),
//               NavIcon(
//                 title: "طلباتي",
//                 isActive: _selectedIndex == 1,
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 1;
//                   });
//                 },
//                 iconData: "assets/icons/order.png",
//               ),
//               NavIcon(
//                 isActive: _selectedIndex == 2,
//                 title: "السلة",
//                 isCart: true,
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 2;
//                   });
//                 },
//                 iconData: "assets/icons/cart.png",
//               ),
//               NavIcon(
//                 isActive: _selectedIndex == 3,
//                 title: "المفضلة",
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 3;
//                   });
//                 },
//                 iconData: "assets/icons/fav.png",
//               ),
//               NavIcon(
//                 title: "الرئيسية",
//                 isActive: _selectedIndex == 0,
//                 onTap: () {
//                   setState(() {
//                     _selectedIndex = 0;
//                   });
//                 },
//                 iconData: "assets/icons/home.png",
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     FocusNode fieldNode = FocusNode();
//
//     return Scaffold(
//       key: _drawerKey,
//       drawer: CustomCategoryDrawer(
//         node: fieldNode,
//         onTapNo: () {
//           Navigator.of(context).pop();
//         },
//         onTapYes: () {
//           Navigator.of(context).pop();
//         },
//       ),
//       body: Stack(
//         children: [
//           Container(
//             height: height(context),
//             child: pages[_selectedIndex],
//           ),
//           Container(height: height(context), child: bottomBar()),
//         ],
//       ),
//     );
//   }
// }
