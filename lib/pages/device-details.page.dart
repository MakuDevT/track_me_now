import 'package:flutter/material.dart';
import 'package:track_me_now/common/widgets/feedback/custom-error.widget.dart';
import 'package:track_me_now/features/device/device-details.screen.dart';

class DeviceDetailsPage extends StatelessWidget {
  final String? deviceId;

  const DeviceDetailsPage({super.key, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Device Details'),
          elevation: 2,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor),
      body: WillPopScope(
          onWillPop: () async {
            await Future.delayed(const Duration(milliseconds: 500));
            return true;
          },
          child: deviceId == null
              ? const CustomErrorWidget(message: 'No device ID provided')
              : DeviceDetailsScreen(deviceId: deviceId!)),
    );
  }
}
