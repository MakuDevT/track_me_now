import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/common/widgets/feedback/custom-error.widget.dart';
import 'package:track_me_now/common/widgets/feedback/loading.widget.dart';
import 'package:track_me_now/data/models/track/track.model.dart';
import 'package:track_me_now/data/providers/device.provider.dart';
import 'package:track_me_now/features/device/widgets/track-card.widget.dart';

class DeviceDetailsScreen extends ConsumerStatefulWidget {
  final String deviceId;

  const DeviceDetailsScreen({super.key, required this.deviceId});

  @override
  DeviceDetailsScreenState createState() => DeviceDetailsScreenState();
}

class DeviceDetailsScreenState extends ConsumerState<DeviceDetailsScreen> {
  GoogleMapController? mapController;
  Marker? marker;
  LatLng? initialCenter;

  void trackHandler(Track track) {
    setState(() {
      marker = Marker(
          markerId: MarkerId(track.dateCreated.toIso8601String()),
          position: LatLng(track.lat, track.lng));
    });
    mapController
        ?.animateCamera(CameraUpdate.newLatLng(LatLng(track.lat, track.lng)));
  }

  @override
  Widget build(BuildContext context) {
    final deviceAsync = ref.watch(deviceProvider(widget.deviceId));

    return deviceAsync.when(
        loading: () => const LoadingWidget(message: 'Fetching device info...'),
        error: (err, stack) => const CustomErrorWidget(
            message: 'Failed to fetch device information'),
        data: (device) {
          if (device.tracks != null && device.tracks!.isNotEmpty) {
            trackHandler(device.tracks![0]);
            initialCenter =
                LatLng(device.tracks![0].lat, device.tracks![0].lng);
          }
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
                                    text: device.id,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ]),
                        ),
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
                                    text: device.id,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w400,
                                    ))
                              ]),
                        ),
                        if (device.tracks != null && device.tracks!.isNotEmpty)
                          RichText(
                            text: TextSpan(
                                text: "Last Date Tracked: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue[900]),
                                children: [
                                  TextSpan(
                                      text: DateTimeUtil.formatDateTime(
                                          device.tracks![0].dateCreated),
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
                            target: initialCenter ??
                                const LatLng(14.5977, 120.9942),
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
                if (device.tracks != null && device.tracks!.isNotEmpty)
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: device.tracks!.length,
                          itemBuilder: (context, index) => TrackCard(
                              track: device.tracks![index],
                              onClick: trackHandler,
                              isActive: marker?.position.latitude ==
                                      device.tracks![index].lat &&
                                  marker?.position.longitude ==
                                      device.tracks![index].lng)))
              ],
            ),
          );
        });
  }
}
