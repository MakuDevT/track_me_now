// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackImpl _$$TrackImplFromJson(Map<String, dynamic> json) => _$TrackImpl(
      id: json['id'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
    );

Map<String, dynamic> _$$TrackImplToJson(_$TrackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'dateCreated': instance.dateCreated.toIso8601String(),
    };
