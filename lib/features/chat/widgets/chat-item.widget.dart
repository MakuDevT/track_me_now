import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/utils/datetime.util.dart';
import 'package:track_me_now/data/models/chat/chat.model.dart';
import 'package:track_me_now/data/models/device/device.model.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';

class ChatItem extends ConsumerStatefulWidget {
  final Chat chatItem;

  const ChatItem({super.key, required this.chatItem});

  @override
  ChatItemState createState() => ChatItemState();
}

class ChatItemState extends ConsumerState<ChatItem> {
  final double paddingSize = 60;
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    Device? device = ref.watch(deviceListProvider).currentDevice;

    return Padding(
      padding: EdgeInsets.fromLTRB(
          device?.id == (widget.chatItem.deviceId ?? widget.chatItem.device?.id)
              ? paddingSize
              : 0,
          4,
          device?.id == (widget.chatItem.deviceId ?? widget.chatItem.device?.id)
              ? 0
              : paddingSize,
          4),
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            tapped = !tapped;
          });
        },
        child: Card(
          color: device?.id ==
                  (widget.chatItem.deviceId ?? widget.chatItem.device?.id)
              ? Colors.blue[100]
              : Colors.blue[300],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.chatItem.message),
                if (tapped)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                        DateTimeUtil.humanizeDateTime(
                            widget.chatItem.dateCreated),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Colors.grey[700],
                            fontSize: 10)),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
