import 'package:flutter/material.dart';

// Wigets
import 'package:erpalerts/Widgets/features/feature_list_item.widget.dart';

class FeatureTagLine extends StatelessWidget {
  const FeatureTagLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "A one stop solution for all your ERP related alerts. Get notified about your ERP notices in real-time.",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }
}

class FeatureList extends StatelessWidget {
  FeatureList({super.key});

  final List<FeatureListModel> featureList = [
    FeatureListModel(icon: Icons.picture_as_pdf, text: "Easy Attachments"),
    FeatureListModel(icon: Icons.timer, text: "Real time notification"),
    FeatureListModel(
        icon: Icons.notifications_active, text: "Push Notifications"),
    FeatureListModel(icon: Icons.login, text: "No manual logins"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: featureList
            .map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: FeatureListItem(model: e),
              ),
            )
            .toList(),
      ),
    );
  }
}
