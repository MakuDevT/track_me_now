import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/mocks/device.mock.dart';
import 'package:track_me_now/data/models/device.model.dart';

class DeviceNotifierState {
  Device? currentDevice;
  List<Device> devices;

  DeviceNotifierState({this.currentDevice, required this.devices});
}

class DeviceNotifier extends StateNotifier<DeviceNotifierState> {
  DeviceNotifier()
      : super(DeviceNotifierState(
            currentDevice: mockDevices[0], devices: mockDevices));

  void setDevices(List<Device> devices) {
    state.devices = devices;
  }

  void setCurrentDevice(Device device) {
    state.currentDevice = device;
  }
}

final deviceProvider =
    StateNotifierProvider<DeviceNotifier, DeviceNotifierState>((ref) {
  return DeviceNotifier();
});
