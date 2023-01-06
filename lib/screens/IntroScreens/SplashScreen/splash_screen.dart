import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as locations;
import 'package:permission_handler/permission_handler.dart';
import 'package:sanaiey/Helper/dio_helper.dart';
import 'package:sanaiey/Helper/helper.dart';
import 'package:sanaiey/constants/colors.dart';
import 'package:sanaiey/controllers/SubControllers/user_controller.dart';
import 'package:sanaiey/screens/IntroScreens/PreLoginScreen/pre_login_screen.dart';
import 'package:sanaiey/screens/MainScreens/HomeScreen/home_screen.dart';
import 'package:sanaiey/screens/SharedComponents/Dialog/app_dialog.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  void _animationState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _animationState();
    getUserData();
    Future.delayed(const Duration(seconds: 2), () {
      navigateToNextScreen();
    });
  }



  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: ScaleTransition(
        scale: _animation,
        child: Center(
          child: Image.asset(
            "assets/app_logo_2.png",
            width: 268.w,
            height: 268.h,
          ),
        ),
      ),
    );
  }

  Future getUserData() async {
    Helper.isLoggedIn = await Helper.getUserLogged() ?? false;
    Helper.token = await Helper.getUserToken() ?? '';
    Helper.userName = await Helper.getUsername() ?? '';
    Helper.userId = await Helper.getUserId() ?? '';
    Helper.clientId = await Helper.getClientId() ?? '';
    Helper.clientName = await Helper.getClientName() ?? '';
  }

  Future<void> navigateToNextScreen() async {
    if (Helper.isLoggedIn == true && Helper.token.isNotEmpty) {
      await DioHelper.init();
      Get.find<UserController>().getData();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const HomeScreen(),
        ),
        (route) => false,
      );
      // Get.offAll(() => HomeScreen());
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const PreLoginScreen(),
        ),
        (route) => false,
      );
    }
  }
}
