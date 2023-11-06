import 'package:flutter/material.dart';

class MapContent extends StatelessWidget {
  const MapContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(
        Icons.map,
        size: 48,
        color: Colors.blue[800],
        shadows: [
          Shadow(color: Colors.amber[800]!, offset: const Offset(2, 2))
        ],
      ),
      const Text('Maps Feature',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
      const SizedBox(height: 12),
      SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset('assets/images/onboarding/b1.png')),
            Expanded(child: Image.asset('assets/images/onboarding/a2.png')),
          ],
        ),
      ),
      const SizedBox(height: 12),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text: 'Your devices can be viewed all at once in Maps Page.')),
      const SizedBox(height: 12),
      RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.black),
              text:
                  'Device Details Page also has a map with marker that points the location of the track entry you tap below.'))
    ]);
  }
}
