import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/providers/device.provider.dart';
import 'package:track_me_now/features/device/widgets/device-card.widget.dart';

class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key});

  @override
  DeviceListScreenState createState() => DeviceListScreenState();
}

class DeviceListScreenState extends ConsumerState<DeviceListScreen> {
  @override
  Widget build(BuildContext context) {
    var devices = ref.watch(deviceProvider).devices;

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: devices.length,
        itemBuilder: (context, index) => DeviceCard(device: devices[index]));
  }
}
