import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_me_now/data/providers/device-list.provider.dart';
import 'package:track_me_now/data/services/remote/device-api.service.dart';
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
    //TODO: Perform Trial, Payment, Devices and User fetching in this section
    super.initState();
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
