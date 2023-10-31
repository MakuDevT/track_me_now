import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/common/utils/tracker.util.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/data/services/local/secure-storage.service.dart';
import 'package:track_me_now/features/authentication/forgot-password.screen.dart';
import 'package:track_me_now/features/authentication/login.screen.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';
import 'package:track_me_now/features/authentication/register.screen.dart';
import 'package:track_me_now/features/authentication/reset-password.screen.dart';
import 'package:track_me_now/features/biometrics/presentation/biometrics.controller.dart';
import 'package:track_me_now/pages/chat.page.dart';
import 'package:track_me_now/pages/device-details.page.dart';
import 'package:track_me_now/pages/main.page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter _router(WidgetRef ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/devices/:deviceId',
        name: 'device-details',
        builder: (context, state) =>
            DeviceDetailsPage(deviceId: state.pathParameters['deviceId']),
      ),
      GoRoute(
        path: '/chat/:roomId',
        name: 'chat',
        builder: (context, state) => ChatPage(
            roomId: state.pathParameters['roomId'],
            deviceId: state.uri.queryParameters['deviceId']),
      ),
      GoRoute(
        redirect: (context, state) async {
          SecureStorageService storage = SecureStorageService();
          var token = await storage.getToken();

          if (token != null) {
            var success = await ref
                .read(authenticationScreenControllerProvider.notifier)
                .getUserInfo();
            if (!success) {
              return null;
            }
            await ref.read(deviceListProvider.notifier).initialize();
            return '/';
          }
          return null;
        },
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey, fullscreenDialog: true, child: LoginScreen()),
      ),
      GoRoute(
          path: '/register',
          name: 'register',
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: RegisterScreen())),
      GoRoute(
          path: '/password-reset/:requestid',
          name: 'passwordReset',
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: ResetPasswordScreen(
                requestId: state.pathParameters['requestid'],
              ))),
      GoRoute(
          path: '/forgot-password',
          name: 'forgotPassword',
          pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: ForgotPasswordScreen())),
    ],
  );
}

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const ProviderScope(child: MyApp()));
  bg.BackgroundGeolocation.registerHeadlessTask(headlessTask);
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Track Me Now',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      routerConfig: _router(ref),
    );
  }
}
