import 'package:flutter/material.dart';
import 'features/anime/bloc/anime_bloc.dart';
import 'features/anime/repositories/anime_repository.dart';
import 'features/anime_by_genre/bloc/anime_genre_bloc.dart';
import 'features/anime_by_genre/repositories/anime_genre_repository.dart';
import 'features/anime_by_genre/services/anime_genre_service.dart';
import 'features/anime_status/bloc/completed/completed_bloc.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/repositories/auth_repository.dart';
import 'features/auth/services/auth_service.dart';
import 'features/episode_detail/bloc/episode_detail_bloc_bloc.dart';
import 'features/episode_detail/repositories/episode_detail_repository.dart';
import 'features/episode_detail/services/episode_detail_service.dart';
import 'features/genre/bloc/genre_bloc.dart';
import 'features/genre/bloc/genre_event.dart';
import 'features/genre/repositories/genre_repository.dart';
import 'features/genre/services/genre_service.dart';
import 'features/anime_status/bloc/ongoing/ongoing_bloc.dart';
import 'features/anime_status/repositories/ongoing_repository.dart';
import 'features/anime_status/services/ongoing_service.dart';
import 'features/history/bloc/history_bloc.dart';
import 'features/history/repositories/history_repository.dart';
import 'features/history/services/history_service.dart';
import 'features/main/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/anime/services/anime_service.dart';
import 'features/anime_detail/bloc/anime_detail_bloc.dart';
import 'features/anime_detail/repositories/anime_detail_repository.dart';
import 'features/anime_detail/services/anime_detail_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        BlocProvider(
          create: (context) => HistoryBloc(
            historyRepository: HistoryRepository(
              historyService: HistoryService(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            authRepository: AuthRepository(
              authService: AuthService(),
            ),
          )..add(CheckAuthEvent()), // Cek status auth saat app mulai
        ),
      ],
      child: MaterialApp(
        title: 'Anime App',
        theme: ThemeData.dark(),
        home: MainScreen(),
      ),
    );
  }
}