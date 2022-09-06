import 'package:delivery/pages/auth/account_page.dart';
import 'package:delivery/pages/auth/sign_in_page.dart';
import 'package:delivery/pages/cart/cart_history.dart';
import 'package:delivery/pages/home/main_food_page.dart';
import 'package:delivery/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List pages = [
    const MainFoodPage(),
    const SignInPage(),
    const CartHistory(),
    const AccountPage()
  ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: Colors.amberAccent,
        currentIndex: _selectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'history'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'me'),
        ],
      ),
    );
  }
}
