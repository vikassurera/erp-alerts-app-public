import 'package:flutter/material.dart';

class GoogleContinueButton extends StatelessWidget {
  const GoogleContinueButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20)),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/google_logo.png',
            height: 30,
          ),
          const SizedBox(width: 12),
          const Text(
            'Continue with Google',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
