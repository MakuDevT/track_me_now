import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/chat/chat-state.model.dart';
import 'package:track_me_now/data/models/chat/chat.model.dart';
import 'package:track_me_now/data/models/room/room.model.dart';
import 'package:track_me_now/data/services/remote/room-api.service.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import "package:track_me_now/common/utils/api.util.dart";

class ChatNotifier extends StateNotifier<ChatListNotifierState> {
  IO.Socket socket;
  ChatNotifier()
      : socket = IO.io(ApiUtil.getBaseUrl(noSuffix: true),
            IO.OptionBuilder().setTransports(['websocket']).build()),
        super(const ChatListNotifierState(chats: [])) {
    socket.onConnect((data) => print("AAAA CONENCTED"));
    socket.on('sendMessage', _listener);
    socket.onDisconnect((_) => print('AAAA DISCONECTED'));
    socket.onConnectError((err) => print('AAAA CONNECT ERROR $err'));
    socket.onError((err) => print('AAAA ERROR $err'));
  }

  void _listener(dynamic data) async {
    var chat = Chat.fromJson(data);
    state = state.copyWith(chats: [...state.chats, chat]);
  }

  Future<Room?> joinRoom(String ownDeviceId, String targetDeviceId) async {
    try {
      var rooms =
          await RoomApiService().searchRoom([ownDeviceId, targetDeviceId]);
      Room? room;
      if (rooms.isEmpty) {
        room = await RoomApiService().createRoom([ownDeviceId, targetDeviceId]);
      } else {
        room = rooms[0];
      }

      Room finalRoom = await RoomApiService().getRoomById(room.id);
      state = state.copyWith(room: room, chats: finalRoom.chats ?? []);
      socket.emit('joinRoom', [
        {"roomId": room.id}
      ]);
      return room;
    } catch (err) {
      return null;
    }
  }

  void sendChat(String deviceId, String message) {
    if (state.room != null) {
      socket.emit('sendMessage', [
        {"roomId": state.room!.id, "deviceId": deviceId, "message": message}
      ]);
    }
  }
}

final chatProvider =
    StateNotifierProvider<ChatNotifier, ChatListNotifierState>((ref) {
  return ChatNotifier();
});
