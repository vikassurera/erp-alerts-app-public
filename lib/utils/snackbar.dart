import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message,
    {Color color = Colors.black}) {
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Text(
      message,
      textAlign: TextAlign.center,
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showErrorBar(BuildContext context, String message) {
  showSnackBar(context, message, color: Colors.red);
}

void showSuccessBar(BuildContext context, String message) {
  showSnackBar(context, message, color: Colors.green);
}
