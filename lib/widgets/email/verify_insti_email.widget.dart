import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/user.controller.dart';

// Widgets
import 'package:erpalerts/widgets/email/email_verification.widget.dart';

class VerifyInstituteEmailWidget extends StatelessWidget {
  VerifyInstituteEmailWidget({super.key});

  final userController = Get.find<UserController>();

  verifyEmailClick(BuildContext context) async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          content: EmailVerificaitonWidget(),
        );
      },
    ).then((value) {
      if (value != null && value) userController.setupUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!userController.isInstiEmailSubmitted &&
            !userController.isInstiEmailVerified)
          TextButton(
            onPressed: () {
              verifyEmailClick(context);
            },
            child: const Text(
              'Verify Institute Email',
              textAlign: TextAlign.center,
            ),
          ),
        if (!userController.isInstiEmailSubmitted &&
            !userController.isInstiEmailVerified)
          const Text(
            "(Must verify institute email to get notifications)",
            textAlign: TextAlign.center,
          ),
        if (userController.isInstiEmailSubmitted &&
            !userController.isInstiEmailVerified)
          Text(
            "Verification email sent to ${userController.instiEmail}",
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        if (userController.isInstiEmailVerified)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${userController.instiEmail!}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                width: 6,
              ),
              if (userController.isInstiEmailVerified)
                const Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
            ],
          ),
      ],
    );
  }
}
