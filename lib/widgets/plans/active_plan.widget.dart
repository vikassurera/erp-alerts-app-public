import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Constants
import 'package:erpalerts/constants/images.constant.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';

// Widgets
import 'package:erpalerts/Widgets/plans/plan_detail.widget.dart';
import 'package:erpalerts/Widgets/plans/transaction_history.widget.dart';
import 'package:erpalerts/Widgets/purchase/pricing_list.widget.dart';

class ActivePlan extends StatelessWidget {
  const ActivePlan({super.key, required this.plan});
  final Plan? plan;

  onViewDetails(Plan plan, BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set to true for a full-screen bottom sheet
      builder: (BuildContext context) {
        return SizedBox(
          height: screenHeight > 350
              ? 350
              : screenHeight, // Adjust the height as needed
          child: PlanDetail(
            plan: plan,
          ),
        );
      },
    );
  }

  onViewTransactionHistory(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set to true for a full-screen bottom sheet
      builder: (BuildContext context) {
        return SizedBox(
          height: screenHeight > 500
              ? 500
              : screenHeight, // Adjust the height as needed
          child: TransactionHistory(
            onViewDetail: onViewDetails,
          ),
        );
      },
    );
  }

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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (plan != null)
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Plan',
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' ${plan!.planState}',
                                style: TextStyle(
                                    fontSize: 14, color: plan!.planStateColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        if (plan!.paidAmount != null)
                          Text("Amount Paid: ₹${plan!.amountPaid}"),
                        if (plan!.paidAmount != null)
                          const SizedBox(
                            height: 3,
                          ),
                        if (plan!.planExpiry != null)
                          Text(
                            "Expiry: ${DateFormat.yMd().add_jm().format(plan!.planExpiry!)}",
                          ),
                        if (plan!.planExpiry != null)
                          const SizedBox(
                            height: 3,
                          ),
                        if (plan!.paidAt != null)
                          Text(
                              "Paid At: ${DateFormat.yMd().add_jm().format(plan!.paidAt!)}"),
                        if (plan!.paidAt != null)
                          const SizedBox(
                            height: 3,
                          ),
                        SelectableText("ID: ${plan!.id}"),
                      ],
                    ),
                    Flexible(
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                            3.14159), // Rotate 180 degrees horizontally
                        child: Image.asset(
                          AppImages.oreoLogo,
                          height: 110,
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onViewDetails(plan!, context);
                      },
                      child: const Text("View Details"),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                      ),
                      onPressed: () {
                        onViewTransactionHistory(context);
                      },
                      child: const Text("View Transaction History"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        if (plan == null || plan?.isExpired == true)
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "No Active Plan",
                textAlign: TextAlign.center,
                style: TextStyle(
                  // color: Colors.red,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
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
                child: const Text("BUY OREO"),
              )
            ],
          ),
      ],
    );
  }
}
