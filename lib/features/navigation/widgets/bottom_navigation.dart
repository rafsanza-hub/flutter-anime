import 'package:flutter/material.dart';
import 'package:flutter_anime/features/genre/screens/genre_screen.dart';
import '../../../utils/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final List<NavigationItem> _items = [
    NavigationItem(icon: Icons.home, label: 'Home'),
    NavigationItem(icon: Icons.category, label: 'Genre'), // Added Genre
    NavigationItem(icon: Icons.search, label: 'Search'),
    NavigationItem(icon: Icons.favorite, label: 'Favorite'),
    NavigationItem(icon: Icons.person, label: 'Profile'),
  ];

  void _onItemTapped(int index, BuildContext context) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle navigation
    if (index == 1) { // Genre index
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  GenreScreen()),
      );
    }
    // Add other navigation cases as needed
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        color: kSearchbarColor.withOpacity(0.9),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _items.map((item) {
            final int index = _items.indexOf(item);
            return InkWell(
              onTap: () => _onItemTapped(index, context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    color: index == _selectedIndex 
                        ? Colors.white 
                        : Colors.white54,
                    size: 30,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: index == _selectedIndex 
                          ? Colors.white 
                          : Colors.white54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Helper class for navigation items
class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem({required this.icon, required this.label});
}