import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.account_circle,
        size: 48,
        color: Colors.blue[800],
        shadows: [
          Shadow(color: Colors.amber[800]!, offset: const Offset(2, 2))
        ],
      ),
      const Text('Profile Feature',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      Image.asset(
        'assets/images/onboarding/d1.png',
        height: 200,
      ),
      const SizedBox(height: 12),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text: 'You can change your password at Profile Page.')),
      const SizedBox(height: 12),
    ]);
  }
}
