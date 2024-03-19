import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Controllers
import 'package:erpalerts/controllers/verify_email.controller.dart';

// Widgets
import 'package:erpalerts/Widgets/buttons/cta_button.widget.dart';

class EmailVerificaitonWidget extends StatefulWidget {
  const EmailVerificaitonWidget({super.key});

  @override
  State<EmailVerificaitonWidget> createState() =>
      _EmailVerificaitonWidgetState();
}

class _EmailVerificaitonWidgetState extends State<EmailVerificaitonWidget> {
  final VerifyEmailController controller = Get.put(VerifyEmailController());

  closePopUp(bool? value) {
    if (controller.isLoading) return;
    Navigator.pop(context, value);
  }

  @override
  void dispose() {
    Get.delete<VerifyEmailController>();
    super.dispose();
  }

  void submitEmail() async {
    final result = await controller.submitEmail();
    if (result) {
      closePopUp(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Verify Institute Email',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "You must verify your institute email in order to use this app.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: controller.emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter institute email',
              ),
            ),
            if (controller.hasError)
              const SizedBox(
                height: 10,
              ),
            if (controller.hasError)
              Text(
                controller.errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(
              height: 20,
            ),
            CTA(
              text: controller.isLoading ? 'Sending...' : 'Send',
              onTap: submitEmail,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "NOTE: You won't be able to update your email later.",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                closePopUp(false);
              },
              child: const Text("Cancel"),
            ),
          ],
        ),
      ),
    );
  }
}
