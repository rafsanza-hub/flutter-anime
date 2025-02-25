import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/bloc/anime_bloc.dart';
import 'package:flutter_anime/features/anime/repositories/anime_repository.dart';
import 'package:flutter_anime/features/anime/screens/home_screen.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_bloc.dart';
import 'package:flutter_anime/features/anime_by_genre/repositories/anime_genre_repository.dart';
import 'package:flutter_anime/features/anime_by_genre/services/anime_genre_service.dart';
import 'package:flutter_anime/features/anime_status/bloc/completed/completed_bloc.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_bloc.dart';
import 'package:flutter_anime/features/episode_detail/repositories/episode_detail_repository.dart';
import 'package:flutter_anime/features/episode_detail/services/episode_detail_service.dart';
import 'package:flutter_anime/features/genre/bloc/genre_bloc.dart';
import 'package:flutter_anime/features/genre/bloc/genre_event.dart';
import 'package:flutter_anime/features/genre/repositories/genre_repository.dart';
import 'package:flutter_anime/features/genre/services/genre_service.dart';
import 'package:flutter_anime/features/anime_status/bloc/ongoing/ongoing_bloc.dart';
import 'package:flutter_anime/features/anime_status/repositories/ongoing_repository.dart';
import 'package:flutter_anime/features/anime_status/screens/ongoing_screen.dart';
import 'package:flutter_anime/features/anime_status/services/ongoing_service.dart';
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
          )..add(FetchAnimeEvent()),
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
        BlocProvider(
          create: (context) => GenreBloc(
            genreRepository: GenreRepository(
              genreService:
                  GenreService(baseUrl: 'http://10.0.2.2:3001/otakudesu'),
            ),
          )..add(FetchGenres()),
        ),
        BlocProvider(
          create: (context) => AnimeGenreBloc(
            animeGenreRepository: AnimeGenreRepository(
              animeGenreService: AnimeGenreService(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => OngoingBloc(
            ongoingRepository: OngoingRepository(
              animeService:
                  StatusService(baseUrl: 'http://10.0.2.2:3001/otakudesu'),
            ),
          ),
          // child: const MoreOngoingScreen(),
        ),
        BlocProvider(
          create: (context) => CompletedBloc(
            completedRepository: OngoingRepository(
              animeService:
                  StatusService(baseUrl: 'http://10.0.2.2:3001/otakudesu'),
            ),
          ),
          // child: const MoreOngoingScreen(),
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
