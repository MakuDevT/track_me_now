// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device-state.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceNotifierStateImpl _$$DeviceNotifierStateImplFromJson(
        Map<String, dynamic> json) =>
    _$DeviceNotifierStateImpl(
      currentDevice: json['currentDevice'] == null
          ? null
          : Device.fromJson(json['currentDevice'] as Map<String, dynamic>),
      tempLat: (json['tempLat'] as num?)?.toDouble(),
      tempLng: (json['tempLng'] as num?)?.toDouble(),
      devices: (json['devices'] as List<dynamic>)
          .map((e) => Device.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeviceNotifierStateImplToJson(
        _$DeviceNotifierStateImpl instance) =>
    <String, dynamic>{
      'currentDevice': instance.currentDevice,
      'tempLat': instance.tempLat,
      'tempLng': instance.tempLng,
      'devices': instance.devices,
    };
