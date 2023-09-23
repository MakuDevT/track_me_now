import 'package:flutter/material.dart';

class TrialContent extends StatelessWidget {
  const TrialContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.timer_outlined,
        size: 48,
        color: Colors.blue[800],
        shadows: [
          Shadow(color: Colors.amber[800]!, offset: const Offset(2, 2))
        ],
      ),
      const SizedBox(height: 24),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 20),
              text: 'Start your\n',
              children: [
                TextSpan(
                    text: '1 Week ',
                    style: TextStyle(fontWeight: FontWeight.w700)),
                TextSpan(text: 'Free Trial')
              ]))
    ]);
  }
}
