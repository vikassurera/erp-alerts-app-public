import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'firebase_options.dart';

// Screena
import 'package:erpalerts/screens/auth.screen.dart';

// Constants
import 'package:erpalerts/constants/app_info.dart';

// Managers
import 'package:erpalerts/managers/storage.manager.dart';

// Services
import 'package:erpalerts/service/local_notification.service.dart';

// Controllers
import 'controllers/bindings.dart';

void main() async {
  // Bindings
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Firebase messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request permission
  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  // Local notification service
  await LocalNotificationService.initialize();

  // Initialise the storage manager
  await StorageManager().init();

  // Google Mobile Ads
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: StoreBinding(),
      title: AppInfo.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
