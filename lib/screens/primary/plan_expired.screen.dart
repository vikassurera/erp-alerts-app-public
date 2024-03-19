import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Widgets
import 'package:erpalerts/widgets/contact/contact_section.widget.dart';
import 'package:erpalerts/widgets/plans/active_plan.widget.dart';

// plan is expired - user can buy a plan
class PlanExpiredScreen extends StatefulWidget {
  const PlanExpiredScreen({super.key});

  @override
  State<PlanExpiredScreen> createState() => _PlanExpiredScreenState();
}

class _PlanExpiredScreenState extends State<PlanExpiredScreen> {
  final userController = Get.find<UserController>();

  @override
  void initState() {
    AnalyticsService().register(Event.APP_PLAN_EXPIRED_SCREEN);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Text(
              "Your plan is expired",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 20,
            ),
            ActivePlan(plan: userController.plan),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 70,
            ),
            const ContactSection(),
          ],
        ),
      ),
    );
  }
}
