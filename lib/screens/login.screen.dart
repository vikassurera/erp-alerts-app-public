import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Controllers
import 'package:erpalerts/controllers/auth.controller.dart';

// Widgets
import 'package:erpalerts/Widgets/buttons/google_login_button.widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final controller = Get.find<AuthController>();

  @override
  void initState() {
    AnalyticsService().register(Event.APP_LOGIN_SCREEN);
    super.initState();
  }

  bool _userConsent = false;

  void _toggleConsent() {
    setState(() {
      _userConsent = !_userConsent;
    });
  }

  final String appUsageMessage =
      'ERP Alerts collects and transmits user actions in the app (app usage) to enable faster and smoother working of the app.';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            padding: const EdgeInsets.all(20.0),
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  const Center(
                    child: Text(
                      "Welcome to ERP Alerts",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Image.asset('assets/alert_logo.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Don't worry about regularly checking ERP notice board\nGet notifications directly into your mobile device",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GoogleContinueButton(
                      onTap:
                          _userConsent ? controller.continueWithGoogle : null,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: _userConsent,
                        onChanged: (value) {
                          _toggleConsent();
                        },
                      ),
                      const Flexible(
                        child: Text(
                          "I agree to share my app (ERP Alerts) usage data",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      appUsageMessage,
                      style: const TextStyle(fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => controller.loggingIn
                ? const CircularProgressIndicator()
                : Container(),
          ),
        ],
      ),
    );
  }
}
