import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime_detail/models/anime_detail_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/colors.dart';
import '../bloc/episode_detail_bloc_bloc.dart';
import '../bloc/episode_detail_bloc_event.dart';
import '../bloc/episode_detail_bloc_state.dart';
import '../models/episode_detail_model.dart';
import '../widgets/video_player_widget.dart';

class EpisodeDetailScreen extends StatefulWidget {
  final String episodeId;

  const EpisodeDetailScreen({
    required this.episodeId,
    Key? key,
  }) : super(key: key);

  @override
  State<EpisodeDetailScreen> createState() => _EpisodeDetailScreenState();
}

class _EpisodeDetailScreenState extends State<EpisodeDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EpisodeDetailBloc>().add(FetchEpisodeDetail(widget.episodeId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocBuilder<EpisodeDetailBloc, EpisodeDetailState>(
        builder: (context, state) {
          return switch (state) {
            EpisodeDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            EpisodeDetailLoaded() =>
              _buildContent(context, state.episodeDetail.data),
            EpisodeDetailError() => Center(
                child: Text(state.message),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, EpisodeDetail episode) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildVideoPlayer(episode.defaultStreamingUrl),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(episode),
                    _buildInfoTags(episode),
                    _buildEpisodeInfo(episode.info),
                    _buildEpisodesList(context, episode.info.episodeList),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
        // _buildCloseButton(context),
      ],
    );
  }

  Widget _buildVideoPlayer(String videoUrl) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: VideoPlayerWidget(videoUrl: videoUrl),
    );
  }

  Widget _buildTitleSection(EpisodeDetail episode) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            episode.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Anime ID: ${episode.animeId}',
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTags(EpisodeDetail episode) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTag(episode.info.type),
          const SizedBox(width: 10),
          _buildTag(episode.info.duration),
          const SizedBox(width: 10),
          ...episode.info.genreList
              .map((genre) => _buildTag(genre.title))
              .expand((widget) => [widget, const SizedBox(width: 10)]),
        ],
      ),
    );
  }

  Widget _buildTag(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
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

  Widget _buildEpisodeInfo(EpisodeInfo info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        _buildInfoItem('Credit', info.credit),
        _buildInfoItem('Encoder', info.encoder),
        _buildInfoItem('Release', info.duration),
      ],
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        '$label: $value',
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildEpisodesList(
      BuildContext context, List<EpisodeNavigation> episodes) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            'Episodes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: episodes.length,
          itemBuilder: (context, index) {
            final episode = episodes[index];
            return ListTile(
              title: Text(
                'Episode ${episode.title}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                episode.episodeId,
                style: const TextStyle(color: Colors.white54),
              ),
              trailing:
                  const Icon(Icons.play_circle_outline, color: kButtonColor),
              onTap: () => _navigateToEpisode(context, episode.episodeId),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Positioned(
      top: 60,
      left: 20,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white24,
        ),
        child: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.close_rounded,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _navigateToEpisode(BuildContext context, String episodeId) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EpisodeDetailScreen(episodeId: episodeId),
      ),
    );
  }
}