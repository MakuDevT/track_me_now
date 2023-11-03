import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:track_me_now/data/services/local/secure-storage.service.dart';
import 'package:track_me_now/data/services/remote/track-api.service.dart';

@pragma('vm:entry-point')
void headlessTask(bg.HeadlessEvent headlessEvent) async {
  switch (headlessEvent.name) {
    case bg.Event.BOOT:
      bg.State state = await bg.BackgroundGeolocation.state;
      print("📬 didDeviceReboot: ${state.didDeviceReboot}");
      break;
    case bg.Event.TERMINATE:
      bg.State state = await bg.BackgroundGeolocation.state;
      if (state.stopOnTerminate!) {
        // Don't request getCurrentPosition when stopOnTerminate: true
        return;
      }
      try {
        bg.Location location =
            await bg.BackgroundGeolocation.getCurrentPosition(
                samples: 1, extras: {"event": "terminate", "headless": true});
        print("[getCurrentPosition] Headless: $location");
      } catch (error) {
        print("[getCurrentPosition] Headless ERROR: $error");
      }
      break;
    case bg.Event.HEARTBEAT:
      try {
        // bg.Location location =
        //     await bg.BackgroundGeolocation.getCurrentPosition(
        //         samples: 2,
        //         timeout: 10,
        //         extras: {"event": "heartbeat", "headless": true});
        // print('[getCurrentPosition] Headless: $location');
      } catch (error) {
        print('[getCurrentPosition] Headless ERROR: $error');
      }
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      SecureStorageService storage = SecureStorageService();

      var deviceId = await storage.getDeviceId();
      var token = await storage.getToken();

      if (token != null && deviceId != null) {
        TrackApiService().createTrack(
            deviceId, location.coords.latitude, location.coords.longitude);

        // await bg.BackgroundGeolocation.setConfig(bg.Config(headers: {
        //   'Authorization': 'Bearer $token'
        // }, params: {
        //   'deviceId': deviceId,
        //   'latitude': location.coords.latitude.toString(),
        //   'longitude': location.coords.longitude.toString()
        // }));
        // bg.BackgroundGeolocation.sync();
      }
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      print(location);
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      print(geofenceEvent);
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      print(state);
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      print(response);
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      print(enabled);
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      print(enabled);
      break;
  }
}
