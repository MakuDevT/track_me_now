import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/models/device.model.dart';

class DeviceCard extends StatelessWidget {
  final Device device;

  const DeviceCard({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.amber[800],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          Expanded(
              flex: 2,
              child: Icon(
                Icons.phone_android,
                size: 72,
                color: Colors.white,
                shadows: [
                  Shadow(
                      blurRadius: 1,
                      color: Colors.blue[600]!,
                      offset: const Offset(2, 2))
                ],
              )),
          const SizedBox(width: 8),
          Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "MAC Address: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900]),
                        children: [
                          TextSpan(
                              text: device.macAddress,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Device Model: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900]),
                        children: [
                          TextSpan(
                              text: device.model,
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))
                        ]),
                  ),
                  RichText(
                    text: TextSpan(
                        text: "Last Date Tracked: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900]),
                        children: [
                          TextSpan(
                              text: DateTimeUtil.formatDateTime(
                                  device.trackHistory[0].createdAt),
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white))
                        ]),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8)),
                          onPressed: () {
                            context.push('/devices/${device.id}');
                          },
                          child: const Text(
                            'View Details',
                          )),
                      const SizedBox(width: 4),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8)),
                          onPressed: () {
                            //TODO: Redirect to ChatPage
                          },
                          child: const Text('Message'))
                    ],
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
