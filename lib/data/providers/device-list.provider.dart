import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/common/utils/device.util.dart';
import 'package:track_me_now/data/models/device/device-state.model.dart';
import 'package:track_me_now/data/services/local/secure-storage.service.dart';
import 'package:track_me_now/data/services/remote/device-api.service.dart';
import 'package:track_me_now/data/services/remote/track-api.service.dart';

class DeviceListNotifier extends StateNotifier<DeviceListNotifierState> {
  DeviceListNotifier() : super(const DeviceListNotifierState(devices: []));
  SecureStorageService storage = SecureStorageService();

  Future<bool> initialize() async {
    try {
      String? macAddress = await DeviceUtil().getDeviceId();
      String? model = await DeviceUtil().getModel();

      var devices = await DeviceApiService().getUserDevices();

      if (devices.isEmpty) await storage.clearDeviceId();

      var currentDeviceIndex =
          devices.indexWhere((device) => device.macAddress == macAddress);

      if (macAddress == null || model == null) {
        //TODO: Add better macAddress handling
        return false;
      }

      if (currentDeviceIndex == -1) {
        var newDevice =
            await DeviceApiService().creteUserDevice(macAddress, model);
        state = state.copyWith(currentDevice: newDevice, devices: devices);
      } else {
        var myDevice = devices.removeAt(currentDeviceIndex);
        state = state.copyWith(currentDevice: myDevice, devices: devices);
      }
      storage.saveDeviceId(state.currentDevice!.id);
      if (state.tempLat != null && state.tempLng != null) {
        await updateLocation(state.tempLat!, state.tempLng!);
        state = state.copyWith(tempLat: null, tempLng: null);
      }
      return true;
    } catch (error) {
      return false;
    }
  }

  void refetch() async {
    var devices = await DeviceApiService().getUserDevices();
    var currentDeviceIndex = devices.indexWhere(
        (device) => device.macAddress == state.currentDevice?.macAddress);

    if (currentDeviceIndex == -1) {
      state = state.copyWith(devices: devices);
    } else {
      var myDevice = devices.removeAt(currentDeviceIndex);
      state = state.copyWith(currentDevice: myDevice, devices: devices);
    }
    state = state.copyWith(devices: devices);
  }

  Future<bool> updateLocation(double lat, double lng) async {
    try {
      var deviceId = await storage.getDeviceId();

      if (deviceId != null) {
        try {
          var track = await TrackApiService().createTrack(deviceId, lat, lng);
          if (state.currentDevice != null) {
            state = state.copyWith(
              currentDevice: state.currentDevice!.copyWith(
                  tracks: [track, ...(state.currentDevice!.tracks ?? [])]),
            );
          }
        } catch (err) {
          state = state.copyWith(tempLat: lat, tempLng: lng);
        }
      } else {
        state = state.copyWith(tempLat: lat, tempLng: lng);
      }
      return true;
    } catch (err) {
      return false;
    }
  }
}

final deviceListProvider =
    StateNotifierProvider<DeviceListNotifier, DeviceListNotifierState>((ref) {
  return DeviceListNotifier();
});
