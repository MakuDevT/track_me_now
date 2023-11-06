import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/models/device/device.model.dart';
import 'package:track_me_now/data/providers/chat.provider.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';

class DeviceCard extends ConsumerWidget {
  final Device device;

  const DeviceCard({super.key, required this.device});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Device? myDevice = ref.watch(deviceListProvider).currentDevice;

    return SizedBox(
      height: 120,
      child: Card(
        elevation: 4,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(children: [
            Expanded(
                flex: 3,
                child: Image.asset(
                  'assets/images/phone.png',
                  scale: 2,
                )),
            const SizedBox(width: 8),
            Expanded(
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      device.model,
                      style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      device.macAddress,
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.grey[600]),
                    ),
                    if (device.tracks != null && device.tracks!.isNotEmpty)
                      Row(
                        children: [
                          Icon(
                            Icons.share_location_rounded,
                            size: 14,
                            color: Colors.blue[900],
                          ),
                          const SizedBox(width: 3),
                          Text(
                            DateTimeUtil.formatDateTime(
                                device.tracks![0].dateCreated),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey[600]),
                          ),
                        ],
                      ),
                  ],
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2,
                        shadowColor: Colors.grey[300],
                        backgroundColor: Colors.white,
                        minimumSize: Size.zero,
                        padding: const EdgeInsets.all(8)),
                    onPressed: () {
                      context.pushNamed('device-details',
                          pathParameters: {'deviceId': device.id});
                    },
                    icon: const Icon(Icons.open_in_new_rounded)),
                const SizedBox(width: 4),
                if (myDevice?.id != device.id)
                  IconButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2,
                          shadowColor: Colors.grey[300],
                          backgroundColor: Colors.white,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.all(8)),
                      onPressed: () async {
                        var room = await ref
                            .read(chatProvider.notifier)
                            .joinRoom(myDevice!.id, device.id);
                        if (room != null) {
                          context.pushNamed('chat',
                              pathParameters: {'roomId': room.id},
                              queryParameters: {'deviceId': device.id});
                        }
                      },
                      icon: const Icon(Icons.chat_outlined))
              ],
            )
          ]),
        ),
      ),
    );
  }
}
