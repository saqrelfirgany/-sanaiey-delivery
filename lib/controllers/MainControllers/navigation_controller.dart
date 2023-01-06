import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sanaiey/Helper/route.dart';
import 'package:sanaiey/screens/MainScreens/CartScreen/cart_screen.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/MainScreens/OrderScreens/orders/my_orders_screen.dart';
import 'package:sanaiey/screens/MainScreens/SubscriptionsScreen/subscriptions_screen.dart';

class NavigationController extends GetxController {
  int index = 0;

  void changeIndexFunction(int index, BuildContext context) {
    this.index = index;
    if (index == 0) {
      fadNavigate(context, HomeScreen());
    } else if (index == 1) {
      // if (Helper.token.isEmpty) {
      //   AccountDialog(context: context);
      //   this.index = 0;
      //   return;
      // }
      fadNavigate(context, MyOrdersScreen());
    } else if (index == 2) {
      // if (Helper.token.isEmpty) {
      //   AccountDialog(context: context);
      //   this.index = 0;
      //   return;
      // }
      fadNavigate(context, CartScreen());
    } else if (index == 3) {
      // if (Helper.token.isEmpty) {
      //   AccountDialog(context: context);
      //   this.index = 0;
      //   return;
      // }
      fadNavigate(context, SubscriptionsScreen());
    }
    update();
  }

  void changeIndexFunctionWithOutNotify(int index) {
    this.index = index;
  }
}
