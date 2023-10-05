import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track_me_now/utils/datetime.util.dart';
import 'package:track_me_now/common/widgets/feedback/custom-error.widget.dart';
import 'package:track_me_now/common/widgets/feedback/loading.widget.dart';
import 'package:track_me_now/data/providers/device.provider.dart';
import 'package:track_me_now/features/device/widgets/details-content.widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeviceDetailsScreen extends ConsumerStatefulWidget {
  final String deviceId;

  const DeviceDetailsScreen({super.key, required this.deviceId});

  @override
  DeviceDetailsScreenState createState() => DeviceDetailsScreenState();
}

class DeviceDetailsScreenState extends ConsumerState<DeviceDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceAsync = ref.watch(deviceProvider(widget.deviceId));

    return deviceAsync.when(
        loading: () => const LoadingWidget(message: 'Fetching device info...'),
        error: (err, stack) => const CustomErrorWidget(
            message: 'Failed to fetch device information'),
        data: (device) {
          return DeviceDetailsContent(
            device: device,
          );
        });
  }
}
