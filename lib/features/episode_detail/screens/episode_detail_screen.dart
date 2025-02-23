import 'package:flutter/material.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_bloc.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_event.dart';
import 'package:flutter_anime/features/episode_detail/bloc/episode_detail_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/episode_detail_model.dart'; // Sesuaikan dengan path model Anda
import '../widgets/video_player_widget.dart'; // Widget untuk video player

class EpisodeDetailScreen extends StatelessWidget {
  final String episodeId;

  const EpisodeDetailScreen({required this.episodeId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger event untuk memuat data episode
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Video Player
                  VideoPlayerWidget(videoUrl: episodeDetail.defaultStreamingUrl),

                  const SizedBox(height: 16),

                  // Judul Episode
                  Text(
                    episodeDetail.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Informasi Dasar
                  _buildInfoSection(episodeDetail),

                  const SizedBox(height: 16),

                  // Server Streaming
                  _buildServerSection(episodeDetail.server),

                  const SizedBox(height: 16),

                  // Link Download
                  _buildDownloadSection(episodeDetail.downloadUrl),

                  const SizedBox(height: 16),

                  // Info Tambahan
                  _buildAdditionalInfoSection(episodeDetail.info),
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

  // Widget untuk menampilkan informasi dasar
  Widget _buildInfoSection(EpisodeDetail episodeDetail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Anime ID: ${episodeDetail.animeId}'),
        Text('Release Time: ${episodeDetail.releaseTime}'),
        Text('Default Streaming URL: ${episodeDetail.defaultStreamingUrl}'),
      ],
    );
  }

  // Widget untuk menampilkan server streaming
  Widget _buildServerSection(Server server) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Streaming Servers',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...server.qualities.map((quality) {
          return ExpansionTile(
            title: Text(quality.title),
            children: quality.serverList.map((serverItem) {
              return ListTile(
                title: Text(serverItem.title),
                subtitle: Text('Server ID: ${serverItem.serverId}'),
                onTap: () {
                  // Tambahkan logika untuk membuka server
                },
              );
            }).toList(),
          );
        }).toList(),
      ],
    );
  }

  // Widget untuk menampilkan link download
  Widget _buildDownloadSection(DownloadUrl downloadUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Download Links',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...downloadUrl.qualities.map((quality) {
          return ExpansionTile(
            title: Text('${quality.title} (${quality.size})'),
            children: quality.urls.map((link) {
              return ListTile(
                title: Text(link.title),
                subtitle: Text(link.url),
                onTap: () {
                  // Tambahkan logika untuk membuka link download
                },
              );
            }).toList(),
          );
        }).toList(),
      ],
    );
  }

  // Widget untuk menampilkan info tambahan
  Widget _buildAdditionalInfoSection(EpisodeInfo info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Info',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text('Credit: ${info.credit}'),
        Text('Encoder: ${info.encoder}'),
        Text('Duration: ${info.duration}'),
        Text('Type: ${info.type}'),
        const SizedBox(height: 16),

        // Daftar Genre
        const Text(
          'Genres',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Wrap(
          spacing: 8,
          children: info.genreList.map((genre) {
            return Chip(
              label: Text(genre.title),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),

        // Daftar Episode
        const Text(
          'Episode List',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...info.episodeList.map((episode) {
          return ListTile(
            title: Text('Episode ${episode.title}'),
            subtitle: Text(episode.episodeId),
            onTap: () {
              // Tambahkan logika untuk navigasi ke episode lain
            },
          );
        }).toList(),
      ],
    );
  }
}