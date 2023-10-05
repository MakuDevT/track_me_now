// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      chats: (json['chats'] as List<dynamic>?)
          ?.map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participants': instance.participants,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'chats': instance.chats,
    };
