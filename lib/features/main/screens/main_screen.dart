import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/screens/home_screen.dart';
import 'package:flutter_anime/features/genre/screens/genre_screen.dart';
import 'package:flutter_anime/utils/colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    GenreScreen(),
    const HomeScreen(),
  ];

  final List<IconData> tabBarIcons = [
    Icons.home,
    Icons.search,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex], 
          Positioned(
            bottom: 30,
            left: 25,
            right: 25,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: kSearchbarColor.withOpacity(0.9),
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    tabBarIcons.length,
                    (index) => GestureDetector(
                      onTap: () => _onItemTapped(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        child: Icon(
                          tabBarIcons[index],
                          color: _selectedIndex == index
                              ? Colors.white
                              : Colors.white54,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
