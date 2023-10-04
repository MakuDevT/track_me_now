import 'package:track_me_now/data/models/track/track.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'device.model.freezed.dart';
part 'device.model.g.dart';

@freezed
class Device with _$Device {
  const factory Device({
    required String id,
    // required String deviceId,
    // required String model,
    required String macAddress,
    required DateTime dateCreated,
    List<Track>? trackHistory,
  }) = _Device;

  factory Device.fromJson(Map<String, Object?> json) => _$DeviceFromJson(json);
}
