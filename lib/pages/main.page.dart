import 'package:flutter/material.dart';
import 'package:track_me_now/features/device/device-list.screen.dart';
import 'package:track_me_now/features/map/map.screen.dart';
import 'package:track_me_now/features/profile/profile-view.screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
    );
  }
}
