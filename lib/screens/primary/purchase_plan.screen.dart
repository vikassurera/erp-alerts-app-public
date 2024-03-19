import 'package:flutter/material.dart';

// Constants
import 'package:erpalerts/constants/images.constant.dart';

// Services
import 'package:erpalerts/service/analytics.service.dart';

// Widgets
import 'package:erpalerts/Widgets/features/feature_list.widget.dart';
import 'package:erpalerts/widgets/purchase/pricing_list.widget.dart';

// Email verified - user can buy a plan
class PurchasePlanScreen extends StatefulWidget {
  const PurchasePlanScreen({super.key});

  @override
  State<PurchasePlanScreen> createState() => _PurchasePlanScreenState();
}

class _PurchasePlanScreenState extends State<PurchasePlanScreen> {
  onBuyOreo(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set to true for a full-screen bottom sheet
      builder: (BuildContext context) {
        return SizedBox(
          height: screenHeight > 500
              ? 500
              : screenHeight, // Adjust the height as needed
          child: const PricingList(),
        );
      },
    );
  }

  @override
  void initState() {
    AnalyticsService().register(Event.APP_PURCHASE_PLAN_SCREEN);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Welcome to ERP Alerts",
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
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
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Let's buy some oreo",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Choose a plan and buy some oreos to get started",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  AppImages.oreoLogo,
                  height: 90,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
              onPressed: () {
                onBuyOreo(context);
              },
              child: const Text("EXPLORE OREO"),
            ),
          ],
        ),
      ),
    );
  }
}
