import 'package:flutter/material.dart';

class ChatContent extends StatelessWidget {
  const ChatContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.chat_bubble,
        size: 48,
        color: Colors.blue[800],
        shadows: [
          Shadow(color: Colors.amber[800]!, offset: const Offset(2, 2))
        ],
      ),
      const Text('Chat Feature',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      Image.asset(
        'assets/images/onboarding/c1.png',
        height: 200,
      ),
      const SizedBox(height: 12),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
                  'You can send and receive chats you your other device by clicking Message button of your device entry in Device List Page.')),
      const SizedBox(height: 12),
    ]);
  }
}
