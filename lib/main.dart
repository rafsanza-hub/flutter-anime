import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/bloc/anime_bloc.dart';
import 'package:flutter_anime/features/anime/repositories/anime_repository.dart';
import 'package:flutter_anime/features/anime/screens/home_screen.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_bloc.dart';
import 'package:flutter_anime/features/episode_detail/repositories/episode_detail_repository.dart';
import 'package:flutter_anime/features/episode_detail/services/episode_detail_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/anime/services/anime_service.dart';
import 'features/anime_detail/bloc/anime_detail_bloc.dart';
import 'features/anime_detail/repositories/anime_detail_repository.dart';
import 'features/anime_detail/services/anime_detail_service.dart'; 

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
              animeService:
                  AnimeService(baseUrl: 'http://10.0.2.2:3001/otakudesu'),
            ),
          ),
        ),
        // BLoC untuk halaman detail
        BlocProvider(
          create: (context) => AnimeDetailBloc(
            animeDetailRepository: AnimeDetailRepository(
              animeDetailService:
                  AnimeDetailService(baseUrl: 'http://10.0.2.2:3001/otakudesu'),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => EpisodeDetailBloc(
            episodeDetailRepository: EpisodeDetailRepository(
              episodeDetailService: EpisodeDetailService(
                  baseUrl: 'http://10.0.2.2:3001/otakudesu'),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Anime App',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
