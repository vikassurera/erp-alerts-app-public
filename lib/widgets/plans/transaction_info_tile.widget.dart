import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Models
import 'package:erpalerts/models/plan.model.dart';

class TransactionInfoTile extends StatelessWidget {
  const TransactionInfoTile(
      {super.key, required this.plan, required this.onViewDetail});
  final Plan plan;
  final Function() onViewDetail;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  plan.planState,
                  style: TextStyle(
                    fontSize: 18,
                    color: plan.planStateColor,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    // backgroundColor: Colors.red,
                    minimumSize: const Size(0, 0),
                  ),
                  onPressed: onViewDetail,
                  child: const Text("View Details"),
                ),
              ],
            ),
            // const SizedBox(
            //   height: 5,
            // ),
            SelectableText("ID: ${plan.id}"),
            Text("Amount Paid: ₹${plan.amountPaid}"),
            const SizedBox(
              height: 3,
            ),
            if (plan.isExpired != null)
              Text(
                "Expiry: ${DateFormat.yMd().add_jm().format(plan.planExpiry!)}",
              ),
            if (plan.isExpired != null)
              const SizedBox(
                height: 3,
              ),
            if (plan.paidAt != null)
              Text(
                  "Paid At: ${DateFormat.yMd().add_jm().format(plan.paidAt!)}"),
            if (plan.paidAt != null)
              const SizedBox(
                height: 3,
              ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'Payment Status: ',
                // Get style from default text theme
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: plan.status,
                    style: TextStyle(
                      // fontSize: 16,
                      color: plan.isStatusSuccess == true
                          ? Colors.green[600]
                          : Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Generated At: ${DateFormat.yMd().add_jm().format(plan.createdAt)}",
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}
