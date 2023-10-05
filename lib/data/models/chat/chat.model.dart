import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:track_me_now/data/models/device/device.model.dart';

part 'chat.model.freezed.dart';
part 'chat.model.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    String? roomId,
    String? deviceId,
    Device? device,
    required String message,
    required DateTime dateCreated,
  }) = _Chat;

  factory Chat.fromJson(Map<String, Object?> json) => _$ChatFromJson(json);
}
