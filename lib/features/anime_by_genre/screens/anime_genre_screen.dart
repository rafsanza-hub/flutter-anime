import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_bloc.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_event.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_state.dart';
import 'package:flutter_anime/features/anime_by_genre/models/anime_genre_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class AnimeGenreScreen extends StatelessWidget {
  final String genreId;
  const AnimeGenreScreen({super.key, required this.genreId});


  @override
  Widget build(BuildContext context) {
    context.read<AnimeGenreBloc>().add(FetchAnimeGenreEvent(genreId: genreId));
    return Scaffold(
      appBar: AppBar(title: Text('AnimeGenre List')),
      body: BlocBuilder<AnimeGenreBloc, AnimeGenreState>(
        builder: (context, state) {
          if (state is AnimeGenreLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AnimeGenreLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: state.animeList
                    .map((anime) => _buildAnimeGenreChip(anime))
                    .toList(),
              ),
            );
          } else if (state is AnimeGenreError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildAnimeGenreChip(Anime anime) {
    return Chip(
      avatar: CircleAvatar(
        backgroundImage: NetworkImage(anime.poster),
      ),
      label: Text(anime.title),
      backgroundColor: Colors.blueAccent.withOpacity(0.2),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    );
  }
}
