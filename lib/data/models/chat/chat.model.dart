import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'chat.model.freezed.dart';
part 'chat.model.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String id,
    required String senderId,
    required String receiverId,
    required String message,
    required DateTime createdAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, Object?> json) => _$ChatFromJson(json);
}
