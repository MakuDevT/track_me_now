import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/common/utils/api.util.dart';
import 'package:track_me_now/common/utils/datetime.util.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:track_me_now/features/authentication/data/authentication.repository.dart';
import 'package:track_me_now/features/authentication/presentation/authentication.controller.dart';
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
  static const List<Widget> _widgetOptions = <Widget>[
    DeviceListScreen(),
    MapsScreen(),
    ProfileViewScreen()
  ];

  int _selectedIndex = 0;
  DateTime? trialDue;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void closeOnboarding(DateTime newTrialDue) {
    setState(() {
      trialDue = newTrialDue;
    });
  }

  @override
  void initState() {
    super.initState();

    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print('[location] - $location');
      postLocation(location.coords.latitude, location.coords.longitude);
    });

    bg.BackgroundGeolocation.onHeartbeat((event) {
      print('[Heartbeat]');
      bg.BackgroundGeolocation.getCurrentPosition(
        samples: 1,
        persist: true,
      );
    });

    bg.BackgroundGeolocation.onMotionChange((bg.Location location) {
      print('[motionchange] - $location');
    });

    bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
      print('[providerchange] - $event');
    });

    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        locationUpdateInterval: 1000,
        //TODO: Reduce this to 1hr
        heartbeatInterval: 60,
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
    ref.listen(authStateChangesProvider, (previousState, state) {
      state.whenData((value) => {
            setState(() {
              trialDue = value?.trialDue != null
                  ? DateTime.parse(value!.trialDue!)
                  : null;
            })
          });
    });

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
              actions: [
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
            unselectedItemColor: Colors.white,
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
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
        if (trialDue == null) OnboardingScreen(onClose: closeOnboarding),
        if (trialDue != null && DateTimeUtil.isPast(trialDue!, DateTime.now()))
          const PaymentBlockerScreen(),
      ],
    );
  }
}
