import 'package:flutter/material.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_bloc.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_event.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EpisodeDetailScreen extends StatelessWidget {
  final String episodeId;

  const EpisodeDetailScreen({required this.episodeId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<EpisodeDetailBloc>().add(FetchEpisodeDetail(episodeId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Episode Detail'),
      ),
      body: BlocBuilder<EpisodeDetailBloc, EpisodeDetailState>(
        builder: (context, state) {
          if (state is EpisodeDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EpisodeDetailLoaded) {
            final episodeDetail = state.episodeDetail.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      episodeDetail.title,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Release Time: ${episodeDetail.releaseTime}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Anime ID: ${episodeDetail.animeId}'),
                  ),
                  // Tambahkan widget lain untuk menampilkan data detail
                ],
              ),
            );
          } else if (state is EpisodeDetailError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}