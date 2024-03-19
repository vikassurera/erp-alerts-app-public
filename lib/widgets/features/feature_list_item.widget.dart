import 'package:flutter/material.dart';

class FeatureListModel {
  final IconData icon;
  final String text;
  final Color? iconColor;

  FeatureListModel({required this.icon, required this.text, this.iconColor});
}

class FeatureListItem extends StatelessWidget {
  const FeatureListItem({
    super.key,
    required this.model,
  });
  final FeatureListModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          model.icon,
          color: model.iconColor,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          model.text,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
