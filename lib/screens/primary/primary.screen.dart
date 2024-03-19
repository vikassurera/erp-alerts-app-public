import 'package:erpalerts/widgets/notice/notice_list.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Screens
import 'package:erpalerts/screens/primary/app_close.screen.dart';
import 'package:erpalerts/screens/primary/error.screen.dart';
import 'package:erpalerts/screens/primary/plan_expired.screen.dart';
import 'package:erpalerts/screens/primary/purchase_plan.screen.dart';
import 'package:erpalerts/screens/primary/welcome.screen.dart';

class PrimaryScreen extends StatefulWidget {
  const PrimaryScreen({super.key});

  @override
  State<PrimaryScreen> createState() => _PrimaryScreenState();
}

class _PrimaryScreenState extends State<PrimaryScreen> {
  Widget getScreen() {
    final access = Get.find<UserController>().mainScreenAccess;

    switch (access) {
      case MAIN_SCREEN_ACCESS.APP_CLOSED:
        return const AppCloseScreen();
      case MAIN_SCREEN_ACCESS.HAVE_TO_VERIFY_EMAIL:
        return const WelcomeScreen();
      case MAIN_SCREEN_ACCESS.PURCHASE_PLAN:
        return const PurchasePlanScreen();
      case MAIN_SCREEN_ACCESS.NOTICE:
        return const NoticeList();
      case MAIN_SCREEN_ACCESS.PLAN_EXPIRED:
        return const PlanExpiredScreen();
      default:
        return const ErrorScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return getScreen();
  }
}
