import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/mocks/device.mock.dart';
import 'package:track_me_now/data/models/user.model.dart';
import 'package:track_me_now/data/providers/device.provider.dart';
import 'package:track_me_now/data/providers/user.provider.dart';
import 'package:track_me_now/pages/chat.page.dart';
import 'package:track_me_now/pages/device-details.page.dart';
import 'package:track_me_now/pages/main.page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/devices/:deviceId',
      builder: (context, state) =>
          DeviceDetailsPage(deviceId: state.pathParameters['deviceId']),
    ),
    GoRoute(
      path: '/chat/:roomId',
      builder: (context, state) => ChatPage(
          roomId: state.pathParameters['roomId'],
          deviceId: state.uri.queryParameters['deviceId']),
    ),
  ],
);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    //TODO: Read information via device_info_plus
    // ref.read(deviceProvider.notifier).setCurrentDevice(mockDevices[0]);
    // ref.read(userProvider.notifier).initialize(
    //     User(email: 'test@gmail.com', name: 'Rick Sanchez', userId: '1'));

    super.initState();

    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print('[location] - $location');
      postLocation(location.coords.latitude, location.coords.longitude);
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)
    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
    });

    // Fired whenever the state of location-services changes.  Always fired at boot
    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    ////
    // 2.  Configure the plugin
    //
    bg.BackgroundGeolocation.ready(bg.Config(
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            locationUpdateInterval: 1000,
            distanceFilter: 0,
            stopOnTerminate: false,
            startOnBoot: true,
            debug: true,
            allowIdenticalLocations: true,
            enableHeadless: true,
            logLevel: bg.Config.LOG_LEVEL_VERBOSE))
        .then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  void postLocation(double lat, double lng) async {
    // final dio = Dio();

    // Response response = await dio.post('http://192.168.1.88:3000/api', data: {'lat': lat, 'lng': lng});
    print(">>>>>>>>> $lat $lng");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Track Me Now',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
