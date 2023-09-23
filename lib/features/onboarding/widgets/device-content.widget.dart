import 'package:flutter/material.dart';

class DeviceContent extends StatelessWidget {
  const DeviceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.phone_android,
        size: 48,
        color: Colors.blue[800],
        shadows: [
          Shadow(color: Colors.amber[800]!, offset: const Offset(2, 2))
        ],
      ),
      const Text('Device Feature',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      const Placeholder(fallbackHeight: 120),
      const SizedBox(height: 12),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
                  'Once you logged in, your device will automatically be registered,tracked and listed in Device List Page.')),
      const SizedBox(height: 12),
      const Placeholder(fallbackHeight: 120),
      const SizedBox(height: 12),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
                  'Each device entry can be interacted and view its full details on Device Details Page.'))
    ]);
  }
}
