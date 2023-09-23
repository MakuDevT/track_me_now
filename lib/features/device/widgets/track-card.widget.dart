import 'package:flutter/material.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/models/track.model.dart';

class TrackCard extends StatelessWidget {
  final Track track;
  final Function(Track) onClick;
  final bool isActive;

  const TrackCard(
      {super.key,
      required this.track,
      required this.onClick,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(track),
      child: Card(
          elevation: isActive ? 2 : 1,
          color: isActive ? Colors.amber[600] : Theme.of(context).cardColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            child: Text(
                '${DateTimeUtil.formatDateTime(track.createdAt)} @ ${track.lat.abs()}°${track.lat > 0 ? 'N' : track.lat < 0 ? 'S' : ''} ${track.lng.abs()}°${track.lat > 0 ? 'E' : track.lat < 0 ? 'W' : ''}'),
          )),
    );
  }
}