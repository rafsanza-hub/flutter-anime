import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/bloc/anime_bloc.dart';
import 'package:flutter_anime/features/anime/repositories/anime_repository.dart';
import 'package:flutter_anime/features/anime/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/anime/services/anime_service.dart';
import 'features/anime_detail/bloc/anime_detail_bloc.dart'; // Import BLoC detail
import 'features/anime_detail/repositories/anime_detail_repository.dart'; // Import repository detail
import 'features/anime_detail/services/anime_detail_service.dart'; // Import service detail

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BLoC untuk halaman home
        BlocProvider(
          create: (context) => AnimeBloc(
            animeRepository: AnimeRepository(
              animeService: AnimeService(baseUrl: 'http://localhost:3001/otakudesu'),
            ),
          ),
        ),
        // BLoC untuk halaman detail
        BlocProvider(
          create: (context) => AnimeDetailBloc(
            animeDetailRepository: AnimeDetailRepository(
              animeDetailService: AnimeDetailService(baseUrl: 'http://localhost:3001/otakudesu'),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Anime App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
      ),
    );
  }
}