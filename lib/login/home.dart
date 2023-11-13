import 'package:flutter/material.dart';


import '../home/welcome.dart';
import '../order/orders_screen.dart';
import '../profile/account_screen.dart';

class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({Key? key}) : super(key: key);

  @override
  State<HomeScreen1> createState() => _HomeScreen1State();
}

class _HomeScreen1State extends State<HomeScreen1> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen2(),
    const OrdersScreen(),
    AccountScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        backgroundColor:
            Colors.white, // Background color of the BottomNavigationBar
        elevation: 10.0, // Elevation for a slight shadow
        type: BottomNavigationBarType.fixed, // Ensure all items are visible
        selectedFontSize: 14.0, // Font size for the selected item
        unselectedFontSize: 14.0, // Font size for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
