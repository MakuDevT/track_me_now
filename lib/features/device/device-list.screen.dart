import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/features/device/widgets/device-card.widget.dart';

class DeviceListScreen extends ConsumerStatefulWidget {
  const DeviceListScreen({super.key});

  @override
  DeviceListScreenState createState() => DeviceListScreenState();
}

class DeviceListScreenState extends ConsumerState<DeviceListScreen> {
  @override
  Widget build(BuildContext context) {
    var myDevice = ref.watch(deviceListProvider).currentDevice;
    var devices = myDevice != null
        ? [myDevice, ...ref.watch(deviceListProvider).devices]
        : ref.watch(deviceListProvider).devices;

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        itemCount: devices.length,
        itemBuilder: (context, index) => DeviceCard(device: devices[index]));
  }
}
