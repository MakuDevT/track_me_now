import 'package:flutter/material.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/models/track/track.model.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  final VoidCallback onClick;
  final bool isActive;

  const TrackCard(
      {super.key,
      required this.track,
      required this.onClick,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
          elevation: isActive ? 2 : 1,
          color: isActive ? Colors.blueGrey[800] : Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${track.lat.abs()}°${track.lat > 0 ? 'N' : track.lat < 0 ? 'S' : ''} ${track.lng.abs()}°${track.lat > 0 ? 'E' : track.lat < 0 ? 'W' : ''}',
                  style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[800]),
                ),
                Text(
                  DateTimeUtil.formatDateTimeShort(track.dateCreated),
                  style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[800],
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                ),
              ],
            ),
          )),
    );
  }
}
