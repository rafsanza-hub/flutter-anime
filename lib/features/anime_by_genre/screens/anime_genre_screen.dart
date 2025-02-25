import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_bloc.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_event.dart';
import 'package:flutter_anime/features/anime_by_genre/bloc/anime_genre_state.dart';
import 'package:flutter_anime/features/anime_by_genre/models/anime_genre_model.dart';
import 'package:flutter_anime/features/anime_detail/screens/anime_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimeGenreScreen extends StatefulWidget {
  final String genreId;
  const AnimeGenreScreen({super.key, required this.genreId});

  @override
  State<AnimeGenreScreen> createState() => _AnimeGenreScreenState();
}

class _AnimeGenreScreenState extends State<AnimeGenreScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AnimeGenreBloc>()
        .add(FetchAnimeGenreEvent(genreId: widget.genreId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime by Genre'),
      ),
      body: BlocBuilder<AnimeGenreBloc, AnimeGenreState>(
        builder: (context, state) {
          if (state is AnimeGenreLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnimeGenreLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.animeList.length,
              itemBuilder: (context, index) {
                final anime = state.animeList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimeDetailScreen(
                            animeId: anime.animeId,
                          ),
                        ),
                      );
                    },
                    child: _buildAnimeCard(anime),
                  ),
                );
              },
            );
          } else if (state is AnimeGenreError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AnimeGenreBloc>().add(
                            FetchAnimeGenreEvent(genreId: widget.genreId),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildAnimeCard(Anime anime) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              anime.poster,
              width: 130,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 130,
                  height: 180,
                  color: Colors.grey[800],
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // Anime Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (anime.score.isNotEmpty) const SizedBox(height: 4),
                if (anime.score.isNotEmpty)
                  _buildInfoText('Rating', anime.score),
                if (anime.episodes != null) const SizedBox(height: 4),
                if (anime.episodes != null)
                  _buildInfoText('Episode', anime.episodes.toString()),
                const SizedBox(height: 4),
                _buildInfoText('Studio', anime.studios),
                const SizedBox(height: 4),
                const SizedBox(height: 4),
                _buildInfoText('Musim', anime.season),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String label, String value) {
    return Text(
      '$label: $value',
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 14,
      ),
    );
  }
}
