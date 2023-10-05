import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:track_me_now/data/models/device/device.model.dart';

part 'device-state.model.freezed.dart';
part 'device-state.model.g.dart';

@freezed
class DeviceListNotifierState with _$DeviceListNotifierState {
  const factory DeviceListNotifierState({
    Device? currentDevice,
    double? tempLat,
    double? tempLng,
    required List<Device> devices,
  }) = _DeviceNotifierState;

  factory DeviceListNotifierState.fromJson(Map<String, Object?> json) =>
      _$DeviceListNotifierStateFromJson(json);
}
