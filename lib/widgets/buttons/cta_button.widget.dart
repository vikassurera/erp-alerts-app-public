import 'package:flutter/material.dart';

class CTA extends StatelessWidget {
  final String text;
  final void Function() onTap;
  const CTA({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 40,
        ),
      ),
      onPressed: onTap,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          // color: Colors.white,
        ),
      ),
    );
  }
}
