import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stay_easy/ui/Home/home_view.dart';
import 'package:stay_easy/ui/bookings/bookings.dart';
import 'package:stay_easy/ui/profile/profile.dart';
import 'package:stay_easy/ui/saved/saved_view.dart';

import '../../constants/colorPallete.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int _currentIndex = 0;
  List<Widget> _pages = [
    HomeView(),
    SavedView(),
    BookingsView(),
    ProfileView(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: TextStyle(
              color: kwhite, fontSize: 9.sp, fontWeight: FontWeight.bold),
          unselectedItemColor: kwhite,
          selectedLabelStyle:
              TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: kwhite,
          backgroundColor: kprimary,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              backgroundColor: kprimary,
              icon: Icon(
                Icons.search,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Saved',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.badge),
              label: 'Bookings',
            ),
            BottomNavigationBarItem(
              backgroundColor: kprimary,
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(
            content: Text('Tap back again to leave'),
          ),
          child: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
        ),
      ),
    );
  }
}
