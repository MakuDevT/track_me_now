import 'package:flutter/material.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset('assets/images/logo.png', height: 72),
      const SizedBox(height: 12),
      const Text('Track Me Now',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      // const Text('Tagline...',
      //     style: TextStyle(
      //         fontSize: 16,
      //         fontWeight: FontWeight.w500,
      //         fontStyle: FontStyle.italic)),
      const SizedBox(height: 24),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
                  'Track Me Now is a mobile app designed to help user track and locate their devices in case of loss.'))
    ]);
  }
}
