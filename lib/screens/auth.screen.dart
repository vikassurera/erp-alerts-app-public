import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/auth.controller.dart';

// Screens
import 'package:erpalerts/screens/splash.screen.dart';
import 'package:erpalerts/widgets/loading.widget.dart';
import 'package:erpalerts/screens/login.screen.dart';

// This screen decides the Login or LoggedIn screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.verifyUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authController.loading
          ? const Scaffold(body: Loading())
          : authController.loggedIn
              ? const LandingScreen()
              : const LoginScreen(),
    );
  }
}
