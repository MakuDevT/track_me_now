import 'dart:async';
import 'package:track_me_now/data/mocks/device.mock.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapsScreen extends StatefulWidget {
  final String? deviceId;

  const MapsScreen({super.key, this.deviceId});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Set<Marker> _markers = {};

  @override
  void initState() {
    //TODO: Perform API fetch/Get devices from state manager

    _markers = mockDevices
        .map(
          (device) => Marker(
              icon: widget.deviceId != null && device.id != widget.deviceId
                  ? BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow)
                  : BitmapDescriptor.defaultMarker,
              markerId: MarkerId(device.id),
              position: LatLng(
                  device.trackHistory[0].lat, device.trackHistory[0].lng),
              infoWindow: InfoWindow(title: device.model),
              alpha: widget.deviceId != null && device.id != widget.deviceId
                  ? 0.6
                  : 1),
        )
        .toSet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.hybrid,
      markers: _markers,
      initialCameraPosition:
          const CameraPosition(target: LatLng(14.5977, 120.9942), zoom: 16),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
