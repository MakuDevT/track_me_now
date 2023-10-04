import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/device/device-state.model.dart';
import 'package:track_me_now/data/services/remote/device-api.service.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceListNotifier extends StateNotifier<DeviceListNotifierState> {
  DeviceListNotifier() : super(const DeviceListNotifierState(devices: [])) {
    _initialize();
  }

  void _initialize() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      String? macAddress;
      String? model;

      if (Platform.isAndroid) {
        var info = await deviceInfo.androidInfo;
        macAddress = info.id;
        model = info.model;
      } else if (Platform.isIOS) {
        var info = await deviceInfo.iosInfo;
        macAddress = info.identifierForVendor;
        model = info.model;
      }

      var devices = await DeviceApiService().getUserDevices();

      state = state.copyWith(devices: devices);

      var myDevice =
          devices.where((device) => device.macAddress == macAddress).toList();

      if (macAddress == null || model == null) {
        //TODO: Add better macAddress handling
        return;
      }

      if (myDevice.isEmpty) {
        var newDevice =
            await DeviceApiService().creteUserDevice(macAddress, model);
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

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, DeviceListNotifierState>((ref) {
  return DeviceListNotifier();
});
