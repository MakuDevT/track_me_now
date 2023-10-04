import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/device/device-state.model.dart';
import 'package:track_me_now/data/services/remote/device-api.service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mac_address/mac_address.dart';

class DeviceNotifier extends StateNotifier<DeviceNotifierState> {
  DeviceNotifier() : super(DeviceNotifierState(devices: [])) {
    _initialize();
  }

  void _initialize() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String? macAddress;

      if (Platform.isAndroid) {
        var info = await deviceInfo.androidInfo;
        macAddress = info.id;
      } else if (Platform.isIOS) {
        var info = await deviceInfo.iosInfo;
        macAddress = info.identifierForVendor;
      }

      var devices = await DeviceApiService().getUserDevices();

      state = state.copyWith(devices: devices);

      var myDevice =
          devices.where((device) => device.macAddress == macAddress).toList();

      if (macAddress == null) {
        //TODO: Add better macAddress handling
        return;
      }

      if (myDevice.isEmpty) {
        var newDevice = await DeviceApiService().creteUserDevice(macAddress!);
        state = state.copyWith(currentDevice: newDevice);
        state = state.copyWith(devices: [...state.devices, newDevice]);
      } else {
        state = state.copyWith(currentDevice: myDevice[0]);
      }
    } catch (error) {
      //TODO: Do something on error
    }
  }

  void refetch() async {
    var devices = await DeviceApiService().getUserDevices();
    state = state.copyWith(devices: devices);
  }
}

final deviceProvider =
    StateNotifierProvider<DeviceNotifier, DeviceNotifierState>((ref) {
  return DeviceNotifier();
});
