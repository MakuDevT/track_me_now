import 'package:track_me_now/data/models/device/device.model.dart';
import 'package:track_me_now/data/models/track/track.model.dart';

List<Device> mockDevices = [
  Device(
      id: '1',
      // deviceId: '1',
      // model: 'Samsung',
      dateCreated: DateTime.now(),
      macAddress: 'AC-11-BB-CC',
      trackHistory: [
        Track(lat: 14.5987, lng: 120.9922, createdAt: DateTime(2023, 8, 8)),
        Track(lat: 14.5977, lng: 120.9932, createdAt: DateTime(2023, 8, 7)),
        Track(lat: 14.5967, lng: 120.9942, createdAt: DateTime(2023, 8, 6)),
        Track(lat: 14.5957, lng: 120.9952, createdAt: DateTime(2023, 8, 5)),
        Track(lat: 14.5947, lng: 120.9962, createdAt: DateTime(2023, 8, 4)),
        Track(lat: 14.5937, lng: 120.9972, createdAt: DateTime(2023, 8, 3)),
        Track(lat: 14.5927, lng: 120.9982, createdAt: DateTime(2023, 8, 2)),
        Track(lat: 14.5917, lng: 120.9992, createdAt: DateTime(2023, 8, 1)),
      ]),
  Device(
      id: '2',
      // deviceId: '2',
      // model: 'Nokia',
      dateCreated: DateTime.now(),
      macAddress: 'AC-11-BB-D0',
      trackHistory: [
        Track(lat: 14.5977, lng: 120.9942, createdAt: DateTime(2023, 8, 1))
      ]),
  Device(
      id: '3',
      // deviceId: '3',
      // model: 'IPhone',
      dateCreated: DateTime.now(),
      macAddress: 'AC-11-BB-EC',
      trackHistory: [
        Track(lat: 14.5957, lng: 120.9932, createdAt: DateTime(2023, 8, 1))
      ]),
];
