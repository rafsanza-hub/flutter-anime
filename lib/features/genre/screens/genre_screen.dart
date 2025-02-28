import 'package:flutter/material.dart';
import '../../anime_by_genre/screens/anime_genre_screen.dart';
import '../bloc/genre_state.dart';
import '../../../utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/genre_bloc.dart';

class GenreScreen extends StatelessWidget {
  const GenreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Genres')),
      body: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GenreLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0, // Jarak antar chip horizontal
                runSpacing: 8.0, // Jarak antar chip vertikal
                children: state.genres.map((genre) {
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AnimeGenreScreen(genreId: genre.genreId),
                      ),
                    ),
                    child: _buildTag(genre.title),
                  );
                }).toList(),
              ),
            );
          } else if (state is GenreError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Tidak ada data.'));
        },
      ),
    );
  }

  Widget _buildTag(String title) {
    return Container(
      // margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: kSearchbarColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white30,
          fontSize: 16,
        ),
      ),
    );
  }
}
