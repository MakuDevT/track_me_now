// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeviceImpl _$$DeviceImplFromJson(Map<String, dynamic> json) => _$DeviceImpl(
      id: json['id'] as String,
      model: json['model'] as String,
      macAddress: json['macAddress'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      tracks: (json['tracks'] as List<dynamic>?)
          ?.map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeviceImplToJson(_$DeviceImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'macAddress': instance.macAddress,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'tracks': instance.tracks,
    };
