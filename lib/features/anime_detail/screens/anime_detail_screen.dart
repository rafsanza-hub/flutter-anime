import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime_detail/bloc/anime_detail_event.dart';
import 'package:flutter_anime/features/anime_detail/bloc/anime_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/anime_detail_bloc.dart';

class AnimeDetailScreen extends StatelessWidget {
  final String animeId;

  const AnimeDetailScreen({required this.animeId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AnimeDetailBloc>().add(FetchAnimeDetail(animeId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime Detail'),
      ),
      body: BlocBuilder<AnimeDetailBloc, AnimeDetailState>(
        builder: (context, state) {
          if (state is AnimeDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnimeDetailLoaded) {
            final animeDetail = state.animeDetail.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(animeDetail.poster),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      animeDetail.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Japanese: ${animeDetail.japanese}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Score: ${animeDetail.score}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Status: ${animeDetail.status}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Episodes: ${animeDetail.episodes}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Duration: ${animeDetail.duration}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Aired: ${animeDetail.aired}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Studios: ${animeDetail.studios}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Synopsis',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(animeDetail.synopsis.paragraphs.join('\n\n')),
                  ),
                ],
              ),
            );
          } else if (state is AnimeDetailError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}