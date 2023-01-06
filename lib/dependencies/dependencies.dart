import 'package:get/get.dart';
import 'package:sanaiey/controllers/IntroControllers/auth_controller.dart';
import 'package:sanaiey/controllers/IntroControllers/select_address_controller.dart';
import 'package:sanaiey/controllers/MainControllers/cart_controller.dart';
import 'package:sanaiey/controllers/MainControllers/department_controller.dart';
import 'package:sanaiey/controllers/MainControllers/fav_controller.dart';
import 'package:sanaiey/controllers/MainControllers/home_controller.dart';
import 'package:sanaiey/controllers/MainControllers/navigation_controller.dart';
import 'package:sanaiey/controllers/MainControllers/order_controller.dart';
import 'package:sanaiey/controllers/MainControllers/pachages_controller.dart';
import 'package:sanaiey/controllers/MainControllers/subscriptions_controller.dart';
import 'package:sanaiey/controllers/SubControllers/location_controller.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/controllers/lang_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  ///
  /// SharedPreferences
  ///
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences, fenix: true);

  ///
  /// API Client
  ///
  // Get.lazyPut(
  //   () => ApiClient(
  //     appBaseUrl: AppConstants.baseUrl,
  //     sharedPreferences: Get.find(),
  //   ),
  // );

  ///
  /// Controller
  ///

  Get.lazyPut(() => LangController(), fenix: true);
  Get.lazyPut(() => SelectAddressController(), fenix: true);
  Get.lazyPut(() => HomeController(), fenix: true);
  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => DepartmentController(), fenix: true);
  Get.lazyPut(() => FavController(), fenix: true);
  Get.lazyPut(() => CartController(), fenix: true);
  Get.lazyPut(() => UserController(), fenix: true);
  Get.lazyPut(() => LocationController(), fenix: true);
  Get.lazyPut(() => PackagesController(), fenix: true);
  Get.lazyPut(() => NavigationController(), fenix: true);
  Get.lazyPut(() => OrderController(), fenix: true);
  Get.lazyPut(() => SubscriptionsController(), fenix: true);

  // Get.lazyPut(() => ThemeController(), fenix: true);
  // Get.lazyPut(() => MainController(), fenix: true);
  // Get.lazyPut(() => AuthController(), fenix: true);
}
