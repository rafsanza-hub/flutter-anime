import 'package:flutter/material.dart';
import 'package:flutter_anime/repositories/anime_repository.dart';
import 'package:flutter_anime/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/anime/anime_bloc.dart';
import 'services/anime_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => AnimeBloc(
          animeRepository: AnimeRepository(
            animeService: AnimeService(baseUrl: 'http://localhost:3001/otakudesu'),
          ), // Ganti dengan base URL API Anda
        ),
        child: HomeScreen(),
      ),
    );
  }
}
