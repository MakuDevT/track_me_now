import 'package:track_me_now/data/models/track.model.dart';

class Device {
  String id;
  String deviceId;
  String model;
  String macAddress;
  List<Track> trackHistory;

  Device({
    required this.id,
    required this.deviceId,
    required this.model,
    required this.macAddress,
    required this.trackHistory,
  });
}
