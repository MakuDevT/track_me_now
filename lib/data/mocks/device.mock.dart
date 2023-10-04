import 'package:track_me_now/data/models/device/device.model.dart';
import 'package:track_me_now/data/models/track/track.model.dart';

List<Device> mockDevices = [
  Device(
      id: '1',
      // deviceId: '1',
      model: 'Samsung',
      dateCreated: DateTime.now(),
      macAddress: 'AC-11-BB-CC',
      tracks: [
        Track(
            id: '1',
            latitude: '14.5987',
            longitude: '120.9922',
            dateCreated: DateTime(2023, 8, 8)),
        Track(
            id: '2',
            latitude: '14.5977',
            longitude: '120.9932',
            dateCreated: DateTime(2023, 8, 7)),
        Track(
            id: '3',
            latitude: '14.5967',
            longitude: '120.9942',
            dateCreated: DateTime(2023, 8, 6)),
        Track(
            id: '4',
            latitude: '14.5957',
            longitude: '120.9952',
            dateCreated: DateTime(2023, 8, 5)),
        Track(
            id: '5',
            latitude: '14.5947',
            longitude: '120.9962',
            dateCreated: DateTime(2023, 8, 4)),
        Track(
            id: '6',
            latitude: '14.5937',
            longitude: '120.9972',
            dateCreated: DateTime(2023, 8, 3)),
        Track(
            id: '7',
            latitude: '14.5927',
            longitude: '120.9982',
            dateCreated: DateTime(2023, 8, 2)),
        Track(
            id: '8',
            latitude: '14.5917',
            longitude: '120.9992',
            dateCreated: DateTime(2023, 8, 1)),
      ]),
  Device(
      id: '2',
      // deviceId: '2',
      model: 'Nokia',
      dateCreated: DateTime.now(),
      macAddress: 'AC-11-BB-D0',
      tracks: [
        Track(
            id: '1',
            latitude: '14.5977',
            longitude: '120.9942',
            dateCreated: DateTime(2023, 8, 1))
      ]),
  Device(
      id: '3',
      // deviceId: '3',
      model: 'IPhone',
      dateCreated: DateTime.now(),
      macAddress: 'AC-11-BB-EC',
      tracks: [
        Track(
            id: '1',
            latitude: '14.5957',
            longitude: '120.9932',
            dateCreated: DateTime(2023, 8, 1))
      ]),
];
