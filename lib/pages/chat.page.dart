import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/common/widgets/feedback/custom-error.widget.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/features/chat/chat.screen.dart';

class ChatPage extends ConsumerWidget {
  final String? roomId;
  final String? deviceId;

  const ChatPage({super.key, this.roomId, this.deviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final device = ref
        .watch(deviceListProvider)
        .devices
        .firstWhere((device) => device.id == deviceId);

    return Scaffold(
      appBar: AppBar(
          title: Text(device.model),
          elevation: 2,
          foregroundColor: Colors.white,
          backgroundColor: Theme.of(context).primaryColor),
      body: roomId == null || deviceId == null
          ? const CustomErrorWidget(
              message: 'No room ID or device ID provided.')
          : ChatScreen(roomId: roomId!, deviceId: deviceId!),
    );
  }
}
