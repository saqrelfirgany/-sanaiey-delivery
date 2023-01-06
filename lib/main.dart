import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_storage/get_storage.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sanaiey/screens/IntroScreens/SplashScreen/splash_screen.dart';
import 'package:sanaiey/utils/check_direction.dart';
import 'package:sanaiey/utils/langs/translation.dart' as trans;
import 'package:sanaiey/utils/local_storage/local_storage.dart';

import 'Helper/dio_helper.dart';
import 'Services/NotificationServices/firebase_messaging_service.dart';
import 'Services/NotificationServices/local_notification_service.dart';
import 'constants/colors.dart';
import 'controllers/lang_controller.dart';
import 'dependencies/dependencies.dart' as dep;

// AIzaSyDUiDM4ojkqlQcneB143r-pD-w6CtbzeTM
void main() async {
  // HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await FirebaseMessagingService.instance.initFirebaseMessaging();
  await LocalNotificationService.instance.initNotificationSettings();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await translator.init(
    localeType: LocalizationDefaultType.asDefined,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
  );

  await dep.init();
  await GetStorage.init();
  await DioHelper.init();
  runApp(
    LocalizedApp(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessagingService.instance.getToken();
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 736),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, widget) => LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return GetBuilder<LangController>(
                builder: (controller) => GetMaterialApp(
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  supportedLocales: [
                    Locale('ar', 'AR'),
                    // Locale('en', 'EN'),
                  ],
                  debugShowCheckedModeBanner: false,
                  themeMode: LocalStorage().theme,
                  translations: trans.Translation(),
                  locale: Locale(controller.selectedLang),
                  fallbackLocale: Locale(controller.selectedLang),
                  theme: ThemeData(
                    canvasColor: Colors.transparent,
                    accentColor: whiteColor,
                    primaryColor: whiteColor,
                    colorScheme: ColorScheme.fromSwatch().copyWith(
                      secondary: whiteColor,
                    ),
                    fontFamily: checkDirection(
                      dirArabic: "cairo",
                      dirEnglish: "sf_pro",
                    ),
                  ),
                  title: 'sanaiey delivery',
                  home: SplashScreen(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
