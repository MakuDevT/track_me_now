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
  // @override
  // void initState() {
  //   //TODO: Read information via device_info_plus
  //   ref.read(deviceProvider.notifier).setCurrentDevice(mockDevices[0]);
  //   ref.read(userProvider.notifier).initialize(
  //       User(email: 'test@gmail.com', name: 'Rick Sanchez', userId: '1'));
  //   super.initState();
  // }

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
