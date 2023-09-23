import 'package:flutter/material.dart';
import 'package:track_me_now/data/mocks/device.mock.dart';
import 'package:track_me_now/features/device/widgets/device-card.widget.dart';

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: mockDevices.length,
        itemBuilder: (context, index) =>
            DeviceCard(device: mockDevices[index]));
  }
}
