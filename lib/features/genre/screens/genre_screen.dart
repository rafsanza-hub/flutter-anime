import 'package:flutter/material.dart';
import '../../anime_by_genre/screens/anime_genre_screen.dart';
import '../bloc/genre_state.dart';
import '../../../utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/genre_bloc.dart';
import '../../../features/search/screens/search_screen.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Genres',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SearchScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<GenreBloc, GenreState>(
                builder: (context, state) {
                  if (state is GenreLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GenreLoaded) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: state.genres.map((genre) {
                          return ActionChip(
                            backgroundColor: kSearchbarColor,
                            side: BorderSide.none,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            label: Text(
                              genre.title,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AnimeGenreScreen(genreId: genre.genreId),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    );
                  } else if (state is GenreError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Tidak ada data.'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
