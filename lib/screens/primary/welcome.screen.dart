import 'package:flutter/material.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Widgets
import 'package:erpalerts/widgets/email/verify_insti_email.widget.dart';
import 'package:erpalerts/widgets/features/feature_list.widget.dart';

// screen where user have to verify email
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    AnalyticsService().register(Event.APP_WELCOME_SCREEN);
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
              "Welcome to ERP Alerts",
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 20,
            ),
            const FeatureTagLine(),
            const SizedBox(
              height: 20,
            ),
            FeatureList(),
            const SizedBox(
              height: 20,
            ),
            VerifyInstituteEmailWidget(),
          ],
        ),
      ),
    );
  }
}
