import 'package:track_me_now/data/models/chat/chat.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.model.freezed.dart';
part 'room.model.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required List<String> participants,
    required DateTime dateCreated,
    List<Chat>? chats,
  }) = _Room;

  factory Room.fromJson(Map<String, Object?> json) => _$RoomFromJson(json);
}
