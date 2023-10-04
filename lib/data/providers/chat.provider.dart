import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/chat/chat.model.dart';

class ChatNotifier extends StateNotifier<List<Chat>> {
  ChatNotifier() : super([]);

  void setChat(List<Chat> chats) {
    state = chats;
  }

  void addChat(Chat chat) {
    state = [...state, chat];
  }

  void deleteChat(String chatId) {
    state = state.where((chat) => chat.id != chatId).toList();
  }
}

final chatProvider = StateNotifierProvider<ChatNotifier, List<Chat>>((ref) {
  return ChatNotifier();
});
