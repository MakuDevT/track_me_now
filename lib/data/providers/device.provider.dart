import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/device/device.model.dart';
import 'package:track_me_now/data/services/remote/device-api.service.dart';

final deviceProvider = FutureProvider.family<Device, String>((ref, deviceId) {
  return DeviceApiService().getUserDevice(deviceId);
});
