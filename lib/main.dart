import 'package:easy_localization/easy_localization.dart';
import 'package:farmer/controller/chat_ctrl.dart';
import 'package:farmer/controller/marketplace_ctrl.dart';
import 'package:farmer/firebase_options.dart';
import 'package:farmer/intro.dart';
import 'package:farmer/screens/auth/verify_otp.dart';
import 'package:farmer/screens/chat.dart';
import 'package:farmer/screens/marketplace/marketplace.dart';
import 'package:farmer/screens/notification.dart';
import 'package:farmer/service/notification_service.dart';
import 'package:farmer/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'import.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  await Get.putAsync(() => DBServices().init());
  await EasyLocalization.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await NotificationService().initNotifications();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi')],
      path: 'assets/lang',
      fallbackLocale: const Locale('en'),
      useFallbackTranslations: true,
      saveLocale: true,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        navigatorKey: navigatorKey,
        title: PROJECT_NAME,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.green,
            primary: Colors.green,
            secondary: Colors.green.shade900,
          ),
          appBarTheme: const AppBarTheme(
            color: Colors.green,
            foregroundColor: Colors.white,
            titleTextStyle: TextStyle(fontSize: 16),
            iconTheme: IconThemeData(color: Colors.white),
            //other options
          ),
          brightness: Brightness.light,
          visualDensity: VisualDensity.compact,
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
              height: 2,
            ),
          ),
        ),
        getPages: [
          GetPage(
            name: '/',
            page: () => const SplashScreen(),
            binding: SplashBinding(),
          ),
          GetPage(
            name: '/intro',
            page: () => const IntroScreen(),
            binding: AuthBinding(),
          ),
          GetPage(
            name: '/login',
            page: () => LoginScreen(),
            binding: AuthBinding(),
          ),
          GetPage(
            name: '/otp',
            page: () => VerifyOTPScreen(),
            binding: AuthBinding(),
          ),
          GetPage(
            name: '/home',
            page: () => const HomeScreen(),
            binding: AppBinding(),
          ),
          GetPage(
            name: '/notification',
            page: () => NotificationScreen(),
            binding: AppBinding(),
          ),
          GetPage(
            name: '/chat',
            page: () => ChatScreen(),
            binding: ChatBinding(),
          ),
          GetPage(
            name: '/marketplace',
            page: () => Marketplace(),
            binding: MarketplaceBinding(),
          ),
        ],
        initialRoute: "/",
      ),
    );
  }
}
