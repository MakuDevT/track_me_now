import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:track_me_now/features/device/device-list.screen.dart';
import 'package:track_me_now/features/map/map.screen.dart';
import 'package:track_me_now/features/onboarding/onboarding.screen.dart';
import 'package:track_me_now/features/payment/payment-blocker.screen.dart';
import 'package:track_me_now/features/profile/profile-view.screen.dart';

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
  bool showBackdrop = false;
  bool isPaymentNEeded = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void closeOnboarding() {
    setState(() {
      showBackdrop = false;
    });
  }

  @override
  void initState() {
    super.initState();
    //TODO: Perform Trial, Payment, Devices and User fetching in this section

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
    ref.read(deviceListProvider.notifier).updateLocation(lat, lng);
  }

  @override
  Widget build(BuildContext context) {
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
        if (showBackdrop) OnboardingScreen(onClose: closeOnboarding),
        if (isPaymentNEeded) const PaymentBlockerScreen(),
      ],
    );
  }
}
