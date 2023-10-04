import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/common/widgets/feedback/custom-error.widget.dart';
import 'package:track_me_now/common/widgets/feedback/loading.widget.dart';
import 'package:track_me_now/data/mocks/device.mock.dart';
import 'package:track_me_now/data/models/device/device.model.dart';
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
  late Future<Device> fetchDevice = Future<Device>.delayed(
    const Duration(seconds: 1),
    () {
      var devices = ref.watch(deviceProvider).devices;

      Device device =
          devices.firstWhere((device) => device.id == widget.deviceId);
      if (device.trackHistory != null && device.trackHistory!.isNotEmpty) {
        trackHandler(device.trackHistory![0]);
        initialCenter =
            LatLng(device.trackHistory![0].lat, device.trackHistory![0].lng);
      }
      return device;
    },
  );

  GoogleMapController? mapController;
  Marker? marker;
  LatLng? initialCenter;

  void trackHandler(Track track) {
    setState(() {
      marker = Marker(
          markerId: MarkerId(track.createdAt.toIso8601String()),
          position: LatLng(track.lat, track.lng));
    });
    mapController
        ?.moveCamera(CameraUpdate.newLatLng(LatLng(track.lat, track.lng)));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Device>(
        future: fetchDevice,
        builder: (BuildContext context, AsyncSnapshot<Device> snapshot) {
          if (snapshot.hasError) {
            return const CustomErrorWidget(
                message: 'Failed to fetch device information');
          }
          if (snapshot.hasData) {
            Device device = snapshot.data!;
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
                          if (device.trackHistory != null &&
                              device.trackHistory!.isNotEmpty)
                            RichText(
                              text: TextSpan(
                                  text: "Last Date Tracked: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blue[900]),
                                  children: [
                                    TextSpan(
                                        text: DateTimeUtil.formatDateTime(
                                            device.trackHistory![0].createdAt),
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
                  if (device.trackHistory != null &&
                      device.trackHistory!.isNotEmpty)
                    Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: device.trackHistory!.length,
                            itemBuilder: (context, index) => TrackCard(
                                track: device.trackHistory![index],
                                onClick: trackHandler,
                                isActive: marker?.position.latitude ==
                                        device.trackHistory![index].lat &&
                                    marker?.position.longitude ==
                                        device.trackHistory![index].lng)))
                ],
              ),
            );
          }
          return const LoadingWidget(message: 'Fetching device info...');
        });
  }
}
