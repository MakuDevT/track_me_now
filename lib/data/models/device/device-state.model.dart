import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:track_me_now/data/models/device/device.model.dart';

part 'device-state.model.freezed.dart';
part 'device-state.model.g.dart';

@freezed
class DeviceNotifierState with _$DeviceNotifierState {
  const factory DeviceNotifierState({
    Device? currentDevice,
    required List<Device> devices,
  }) = _DeviceNotifierState;

  factory DeviceNotifierState.fromJson(Map<String, Object?> json) =>
      _$DeviceNotifierStateFromJson(json);
}
