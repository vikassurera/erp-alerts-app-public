import 'package:flutter/material.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Widgets
import 'package:erpalerts/widgets/contact/contact_section.widget.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  void initState() {
    AnalyticsService().register(Event.APP_ERROR_SCREEN);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Something went wrong",
                    style: Theme.of(context).textTheme.headline5,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "App faced some unexpected error. Please try again later.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  const ContactSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
