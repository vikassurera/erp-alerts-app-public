import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

class AlertSettings extends StatelessWidget {
  AlertSettings({super.key});
  final UserController userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Column(
            children: [
              const Text(
                'Notification Settings',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'enable PLACEMENT alerts',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.grey,
                    ),
                  ),
                  Switch(
                    value: userController.enablePlacementAlerts,
                    onChanged: (value) {
                      if (userController.isLoading) return;
                      userController.enablePlacementAlerts = value;
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'enable INTERNSHIP alerts',
                    style: TextStyle(
                      fontSize: 14,
                      // color: Colors.grey,
                    ),
                  ),
                  Switch(
                    value: userController.enableInternshipAlerts,
                    onChanged: (value) {
                      if (userController.isLoading) return;
                      userController.enableInternshipAlerts = value;
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          userController.isUpdatingSetting
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox(
                  height: 0,
                  width: 0,
                ),
        ],
      ),
    );
  }
}
