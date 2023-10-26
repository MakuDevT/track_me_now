import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/models/device/device.model.dart';
import 'package:track_me_now/data/models/track/track.model.dart';
import 'package:track_me_now/features/device/widgets/track-card.widget.dart';

class DeviceDetailsContent extends ConsumerStatefulWidget {
  final Device device;
  const DeviceDetailsContent({super.key, required this.device});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeviceDetailsContentState();
}

class _DeviceDetailsContentState extends ConsumerState<DeviceDetailsContent> {
  GoogleMapController? mapController;
  Marker? marker;
  LatLng? initialCenter;
  Track? activeTrack;

  trackHandler(Track track) {
    setState(() {
      activeTrack = track;
      marker = Marker(
          markerId: MarkerId(track.dateCreated.toIso8601String()),
          position: LatLng(track.lat, track.lng));
    });
    mapController
        ?.animateCamera(CameraUpdate.newLatLng(LatLng(track.lat, track.lng)));
  }

  @override
  void initState() {
    if (widget.device.tracks != null && widget.device.tracks!.isNotEmpty) {
      trackHandler(widget.device.tracks![0]);
      initialCenter =
          LatLng(widget.device.tracks![0].lat, widget.device.tracks![0].lng);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Device Information',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Icon(
                Icons.phone_android,
                size: 72,
                color: Colors.blue[800],
                shadows: [
                  Shadow(
                      blurRadius: 1,
                      color: Colors.amber[800]!,
                      offset: const Offset(2, 2))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                        text: "Device ID: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue[900]),
                        children: [
                          TextSpan(
                              text: widget.device.macAddress,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ))
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
                              text: widget.device.model,
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ))
                        ]),
                  ),
                  if (widget.device.tracks != null &&
                      widget.device.tracks!.isNotEmpty)
                    RichText(
                      text: TextSpan(
                          text: "Last Date Tracked: ",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.blue[900]),
                          children: [
                            TextSpan(
                                text: DateTimeUtil.formatDateTime(
                                    widget.device.tracks![0].dateCreated),
                                style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w400,
                                ))
                          ]),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
                height: 200,
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  markers: marker != null ? {marker!} : {},
                  initialCameraPosition: CameraPosition(
                      target: initialCenter ?? const LatLng(14.5977, 120.9942),
                      zoom: 16),
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                )),
          ),
          const Divider(),
          const Text(
            'Track History',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          if (widget.device.tracks != null && widget.device.tracks!.isNotEmpty)
            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.device.tracks!.length,
                    itemBuilder: (context, index) => TrackCard(
                        track: widget.device.tracks![index],
                        onClick: () =>
                            trackHandler(widget.device.tracks![index]),
                        isActive: activeTrack?.dateCreated ==
                            widget.device.tracks![index].dateCreated)))
        ],
      ),
    );
  }
}
