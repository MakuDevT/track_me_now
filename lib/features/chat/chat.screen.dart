import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/models/chat/chat.model.dart';
import 'package:track_me_now/data/providers/chat.provider.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/features/chat/widgets/chat-item.widget.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String roomId;
  final String deviceId;

  const ChatScreen({super.key, required this.roomId, required this.deviceId});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  TextEditingController textController = TextEditingController();
  ScrollController scrollController = ScrollController();

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  void sendHandler(String text) {
    String? myDeviceId = ref.read(deviceListProvider).currentDevice?.id;

    if (myDeviceId == null || text.isEmpty) return;

    ref.read(chatProvider.notifier).sendChat(myDeviceId, text);

    textController.text = '';

    _scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    final List<Chat> chats = ref.watch(chatProvider).chats;

    return Column(mainAxisSize: MainAxisSize.max, children: [
      Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: chats.length,
                itemBuilder: (context, index) =>
                    ChatItem(chatItem: chats[index])),
          )),
      Container(
          decoration: BoxDecoration(color: Colors.blue[800], boxShadow: const [
            BoxShadow(
                blurRadius: 1,
                spreadRadius: 1.5,
                offset: Offset(0, -0.5),
                color: Colors.grey)
          ]),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: TextField(
            textInputAction: TextInputAction.send,
            controller: textController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: IconButton(
                  onPressed: () {
                    sendHandler(textController.text);
                  },
                  icon: Icon(Icons.send, color: Colors.blue[800]!)),
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  borderSide: BorderSide.none),
              labelText: 'Send message',
            ),
            onSubmitted: sendHandler,
          ))
    ]);
  }
}
