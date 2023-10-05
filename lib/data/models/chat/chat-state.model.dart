import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:track_me_now/data/models/chat/chat.model.dart';
import 'package:track_me_now/data/models/room/room.model.dart';

part 'chat-state.model.freezed.dart';
part 'chat-state.model.g.dart';

@freezed
class ChatListNotifierState with _$ChatListNotifierState {
  const factory ChatListNotifierState({
    Room? room,
    required List<Chat> chats,
  }) = _ChatListNotifierState;

  factory ChatListNotifierState.fromJson(Map<String, Object?> json) =>
      _$ChatListNotifierStateFromJson(json);
}
