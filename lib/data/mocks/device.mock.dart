import 'package:track_me_now/data/models/device.model.dart';
import 'package:track_me_now/data/models/track.model.dart';

List<Device> mockDevices = [
  Device(id: '1', deviceId: '1', model: 'Samsung', macAddress: 'AC-11-BB-CC', trackHistory: [
    Track(lat: 14.5997, lng: 120.9922, createdAt: DateTime(2023, 8, 1))
  ]),
  Device(id: '2', deviceId: '2', model: 'Nokia', macAddress: 'AC-11-BB-D0', trackHistory: [
    Track(lat: 14.5977, lng: 120.9942, createdAt: DateTime(2023, 8, 1))
  ]),
  Device(id: '3', deviceId: '3', model: 'IPhone', macAddress: 'AC-11-BB-EC', trackHistory: [
    Track(lat: 14.5957, lng: 120.9932, createdAt: DateTime(2023, 8, 1))
  ]),
];
