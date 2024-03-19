import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/auth.controller.dart';
import 'package:erpalerts/controllers/user.controller.dart';

// Widgets
import 'package:erpalerts/widgets/user/alert_settings.widget.dart';
import 'package:erpalerts/widgets/contact/contact_section.widget.dart';
import 'package:erpalerts/widgets/email/verify_insti_email.widget.dart';
import 'package:erpalerts/widgets/plans/active_plan.widget.dart';

class UserInfo extends StatelessWidget {
  UserInfo({
    Key? key,
  }) : super(key: key);

  final UserController userController = Get.find<UserController>();
  final String appUsageMessage =
      'ERP Alerts collects and transmits user actions in the app (app usage) to enable faster and smoother working of the app.';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Card(
              child: ListTile(
                contentPadding: const EdgeInsets.only(
                    top: 15, left: 20, right: 20, bottom: 0),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            userController.avatarUrl != null
                                ? CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userController.avatarUrl!),
                                    radius: 30,
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 30,
                                    child: Text(
                                      userController.displayName
                                          .substring(0, 2)
                                          .toUpperCase(),
                                      style: const TextStyle(fontSize: 30),
                                    ),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userController.displayName,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  userController.email ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Get.find<AuthController>().logout(),
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    VerifyInstituteEmailWidget(),
                    const SizedBox(
                      height: 20,
                    ),
                    if (userController.isInstiEmailVerified)
                      ActivePlan(plan: userController.plan),
                    SizedBox(
                      height: 20,
                    ),
                    if (userController.isInstiEmailVerified &&
                        userController.plan != null &&
                        userController.plan?.isExpired == false)
                      AlertSettings(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                appUsageMessage,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const ContactSection(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
