import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';

class MapsScreen extends ConsumerStatefulWidget {
  final String? deviceId;

  const MapsScreen({super.key, this.deviceId});

  @override
  MapsScreenState createState() => MapsScreenState();
}

class MapsScreenState extends ConsumerState<MapsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    var markers = [
      ref.watch(deviceListProvider).currentDevice!,
      ...ref.watch(deviceListProvider).devices
    ]
        .where((device) => device.tracks != null)
        .map(
          (device) => Marker(
              icon: widget.deviceId != null && device.id != widget.deviceId
                  ? BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow)
                  : BitmapDescriptor.defaultMarker,
              markerId: MarkerId(device.id),
              position: LatLng(device.tracks![0].lat, device.tracks![0].lng),
              infoWindow: InfoWindow(title: device.model),
              alpha: widget.deviceId != null && device.id != widget.deviceId
                  ? 0.6
                  : 1),
        )
        .toSet();

    return GoogleMap(
        mapType: MapType.hybrid,
        markers: markers,
        initialCameraPosition:
            const CameraPosition(target: LatLng(14.5977, 120.9942), zoom: 16),
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);

          if (markers.isEmpty) return;

          if (markers.length == 1) {
            controller.animateCamera(CameraUpdate.newLatLng(LatLng(
                markers.first.position.latitude,
                markers.first.position.longitude)));
            return;
          }
          double? x0, x1, y0, y1;

          for (Marker marker in markers) {
            if (x0 == null) {
              x0 = x1 = marker.position.latitude;
              y0 = y1 = marker.position.longitude;
            } else {
              if (marker.position.latitude > x1!) x1 = marker.position.latitude;
              if (marker.position.latitude < x0) x0 = marker.position.latitude;
              if (marker.position.longitude > y1!)
                y1 = marker.position.longitude;
              if (marker.position.longitude < y0!)
                y0 = marker.position.longitude;
            }
          }
          await Future.delayed(
              const Duration(milliseconds: 500),
              () => controller.animateCamera(CameraUpdate.newLatLngBounds(
                  LatLngBounds(
                      northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!)),
                  60)));
        });
  }
}
