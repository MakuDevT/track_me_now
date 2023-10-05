// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat-state.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatListNotifierStateImpl _$$ChatListNotifierStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ChatListNotifierStateImpl(
      room: json['room'] == null
          ? null
          : Room.fromJson(json['room'] as Map<String, dynamic>),
      chats: (json['chats'] as List<dynamic>)
          .map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ChatListNotifierStateImplToJson(
        _$ChatListNotifierStateImpl instance) =>
    <String, dynamic>{
      'room': instance.room,
      'chats': instance.chats,
    };
