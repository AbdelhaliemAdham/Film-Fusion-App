import 'package:flutter/material.dart';
import 'package:movie/helper/assets.dart';
import 'package:movie/screens/categories_screen.dart';
import 'package:movie/screens/myhome_screen.dart';
import 'package:movie/screens/profile_screen.dart';
import 'package:movie/screens/watchList_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> screens = const [
    MyHomePage(),
    CategoriesScreen(),
    WatchListScreen(),
    ProfileScreen(),
  ];
  int navBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: navBarIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(14, 15, 22, 1),
          type: BottomNavigationBarType.fixed,
          currentIndex: navBarIndex,
          onTap: (index) {
            setState(() {
              navBarIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey), label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded, color: Colors.grey),
                label: 'Categories'),
            BottomNavigationBarItem(
                icon: Image.asset(Assets.bookMark,
                    width: 20, height: 20, color: Colors.grey),
                label: 'Watch later'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.grey), label: 'Profile'),
          ]),
    );
  }
}
