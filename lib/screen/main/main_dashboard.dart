import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wholesale_admin/screen/pages/home_page.dart';
import 'package:wholesale_admin/screen/pages/profile_page.dart';
import 'package:wholesale_admin/screen/pages/user_page.dart';
import 'package:wholesale_admin/utils/colors.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    UserPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(color: Colors.blue),
        backgroundColor: primary,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'Home',
            backgroundColor: primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.trip_origin,
              color: _currentIndex == 1 ? Colors.blue : Colors.grey,
            ),
            label: 'Orders',
            backgroundColor: primary,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _currentIndex == 3 ? Colors.blue : Colors.grey,
            ),
            label: 'Account',
            backgroundColor: primary,
          ),
        ],
      ),
    );
  }
}
