import 'package:flutter/material.dart';
import 'package:clean_pro/screens/bookings_screen.dart';
import 'package:clean_pro/screens/profile_screen.dart';
import 'package:clean_pro/screens/services_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final Color _barIconColor = Colors.indigo.shade500;
  final Color _selectedIconColor = Colors.indigo.shade500;
  final Color _barColor = Colors.blue.shade50;

  final List<Widget> _screens = [
    ServicesScreen(),
    BookingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CleanPro',
          style: TextStyle(
            fontSize: 24,
            color: _barIconColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _barColor,
        actions: [
          TextButton.icon(
            icon: Icon(Icons.login),
            onPressed: () {
              // Handle login
            },
            label: Text(
              'Login',
              style: TextStyle(
                color: _barIconColor,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: TextButton.styleFrom(
              minimumSize: Size(24, 24),
              iconColor: _barIconColor,
              iconSize: 24,
            ),
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        selectedItemColor: _selectedIconColor,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              _selectedIndex == 0
                  ? Icons.assignment
                  : Icons.assignment_outlined,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1
                ? Icon(Icons.book)
                : Icon(Icons.book_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2
                ? Icon(Icons.account_circle)
                : Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        backgroundColor: _barColor,
      ),
    );
  }
}
