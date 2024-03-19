import 'package:flutter/material.dart';

// Constants
import 'package:erpalerts/constants/images.constant.dart';

// Models
import 'package:erpalerts/models/pricing.model.dart';

class PricingCard extends StatelessWidget {
  final Pricing pricing;
  final Function() onSelect;
  final bool enablePayment;

  const PricingCard({
    Key? key,
    required this.pricing,
    required this.onSelect,
    required this.enablePayment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              pricing.title,
              style: const TextStyle(
                fontSize: 18,
                // fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '${pricing.currencySymbol}${pricing.priceAmount}',
                style: const TextStyle(fontSize: 36, color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: '/${pricing.validity}',
                    style: const TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${pricing.currencySymbol}${pricing.strikeAmount}/${pricing.validity}',
              style: const TextStyle(
                fontSize: 16,
                decoration: TextDecoration.lineThrough,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.oreoLogo,
                  height: 90,
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(
                      3.14159), // Rotate 180 degrees horizontally
                  child: Image.asset(
                    AppImages.oreoLogo,
                    height: 90,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Validity for ${pricing.validityDays} days',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 50,
                ),
              ),
              onPressed: enablePayment ? () => {onSelect()} : null,
              child: const Text(
                'SELECT OREO',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // ...pricing.features
            //     .map((value) => Text(
            //           "• ${value}",
            //           style: const TextStyle(
            //             fontSize: 14,
            //           ),
            //         ))
            //     .toList()
          ],
        ),
      ),
    );
  }
}
