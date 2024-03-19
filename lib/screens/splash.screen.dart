import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Screens
import 'package:erpalerts/screens/home.screen.dart';

// Widgets
import 'package:erpalerts/widgets/loading.widget.dart';

// Buffer Screen to load user data
class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    userController.setupUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => userController.isLoading
        ? const Scaffold(body: Loading())
        : const HomeScreen());
  }
}
