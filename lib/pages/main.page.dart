import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:track_me_now/common/utils/api.util.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:track_me_now/data/services/local/secure-storage.service.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';
import 'package:track_me_now/features/biometrics/presentation/biometrics.controller.dart';
import 'package:track_me_now/features/device/device-list.screen.dart';
import 'package:track_me_now/features/map/map.screen.dart';
import 'package:track_me_now/features/onboarding/onboarding.screen.dart';
import 'package:track_me_now/features/payment/payment-blocker.screen.dart';
import 'package:track_me_now/features/profile/presentation/profile-view.screen.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends ConsumerState<MainPage> {
  final SecureStorageService storage = SecureStorageService();
  static const List<Widget> _widgetOptions = <Widget>[
    DeviceListScreen(),
    MapsScreen(),
    ProfileViewScreen()
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> firstLoggedIn() async {
    if (await storage.getIsFirstLoggedIn() == "true") {
      ref
          .read(biometricsScreenControllerProvider.notifier)
          .authenticateWithBiometrics();
    }

    storage.saveIsFirstLoggedIn('true');
  }

  @override
  void initState() {
    firstLoggedIn();
    super.initState();
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print('[location] - $location');
      postLocation(location.coords.latitude, location.coords.longitude);
    });

    // bg.BackgroundGeolocation.onHeartbeat((event) {
    //   print('[Heartbeat]');
    //   bg.BackgroundGeolocation.getCurrentPosition(
    //     samples: 1,
    //     persist: true,
    //   );
    // });

    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
    });

    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        locationUpdateInterval: 1000,
        // heartbeatInterval: 3600,
        fastestLocationUpdateInterval: 60,
        distanceFilter: 0,
        preventSuspend: true,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        allowIdenticalLocations: false,
        enableHeadless: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        autoSync: false,
        url: '${ApiUtil.getBaseUrl()}/track/create',
        method: 'POST',
        params: {})).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  void postLocation(double lat, double lng) async {
    ref.read(deviceListProvider.notifier).updateLocation(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authenticationScreenControllerProvider);
    final user =
        ref.watch(authenticationScreenControllerProvider.notifier).userData;
    ref.listen(biometricsScreenControllerProvider,
        (previousState, state) async {
      if (state.hasError) {
        ref.read(authenticationScreenControllerProvider.notifier).signOut();
        context.pushReplacementNamed('login');
      }
    });
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.indigo[100],
          appBar: AppBar(
              actions: [
                if (_selectedIndex != 2)
                  IconButton(
                      onPressed: () {
                        ref.read(deviceListProvider.notifier).refetch();
                      },
                      icon: const Icon(Icons.refresh))
              ],
              title: const Text('Track Me Now'),
              elevation: 2,
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor),
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue[900],
            unselectedItemColor: Colors.blueGrey[300],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.devices),
                label: 'Devices',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ),
        if (user.trialDue == null) const OnboardingScreen(),
        if (!(user.isSubscribed ?? false) &&
            (user.trialDue != null &&
                DateTimeUtil.isPast(
                    DateTime.parse(user.trialDue!), DateTime.now())))
          const PaymentBlockerScreen(),
      ],
    );
  }
}
