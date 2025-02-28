import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_anime/features/anime/screens/home_screen.dart';
import 'package:flutter_anime/features/genre/screens/genre_screen.dart';
import 'package:flutter_anime/features/history/screens/history_screen.dart';
import 'package:flutter_anime/utils/colors.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/screens/login_screen.dart';
import '../../profile/screens/profile_screen.dart';

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
    const HistoryScreen(), 
    const ProfileScreen(),
  ];

  final List<IconData> tabBarIcons = [
    Icons.home,
    Icons.search,
    Icons.history,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginScreen()));
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is AuthAuthenticated) {
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
                              child: index == 3
                                  ? CircleAvatar(
                                      radius: 15,
                                      backgroundImage: state.user.avatarUrl !=
                                              null
                                          ? NetworkImage(state.user.avatarUrl!)
                                          : null,
                                      child: state.user.avatarUrl == null
                                          ? const Icon(Icons.person,
                                              size: 15, color: Colors.white)
                                          : null,
                                    )
                                  : Icon(
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
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
