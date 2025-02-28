import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import '../../../utils/colors.dart';
import '../bloc/anime_detail_bloc.dart';
import '../bloc/anime_detail_state.dart';
import '../bloc/anime_detail_event.dart';
import '../models/anime_detail_model.dart';
import '../../episode_detail/screens/episode_detail_screen.dart';
import '../../history/bloc/history_bloc.dart'; // Tambah import
import '../../history/models/history_model.dart'; // Tambah import

class AnimeDetailScreen extends StatefulWidget {
  final String animeId;

  const AnimeDetailScreen({
    required this.animeId,
    super.key,
  });

  @override
  State<AnimeDetailScreen> createState() => _AnimeDetailScreenState();
}

class _AnimeDetailScreenState extends State<AnimeDetailScreen> {
  @override
  void initState() {
    context.read<AnimeDetailBloc>().add(FetchAnimeDetail(widget.animeId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocBuilder<AnimeDetailBloc, AnimeDetailState>(
        builder: (context, state) {
          return switch (state) {
            AnimeDetailLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            AnimeDetailLoaded() =>
              _buildContent(context, state.animeDetail.data),
            AnimeDetailError() => Center(
                child: Text(state.message),
              ),
            _ => const SizedBox.shrink(),
          };
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, AnimeDetail anime) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _buildHeroImage(anime.poster),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleSection(anime),
                    _buildGenreTags(anime),
                    _buildSynopsis(anime),
                    _buildInfoSection(anime),
                    _buildEpisodesList(context, anime.episodeList),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ],
          ),
        ),
        _buildCloseButton(context),
        _buildWatchButton(context, anime.episodeList.last.episodeId),
      ],
    );
  }

  Widget _buildHeroImage(String imageUrl) {
    return SizedBox(
      width: double.infinity,
      height: 500,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    kBackgroundColor.withOpacity(0.8),
                    kBackgroundColor,
                  ],
                  stops: const [0.0, 0.4, 0.75, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleSection(AnimeDetail anime) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anime.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  anime.japanese,
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenreTags(AnimeDetail anime) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 10),
          ...anime.genreList
              .map((e) => _buildTag(e.title))
              .expand((widget) => [widget, const SizedBox(width: 10)]),
          const SizedBox(width: 10),
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

  Widget _buildSynopsis(AnimeDetail anime) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ReadMoreText(
        anime.synopsis.paragraphs.join('\n\n'),
        trimLines: 3,
        trimMode: TrimMode.Line,
        moreStyle: const TextStyle(color: kButtonColor),
        lessStyle: const TextStyle(color: kButtonColor),
        style: const TextStyle(
          color: Colors.white70,
          height: 1.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoSection(AnimeDetail anime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoItem('Studios', anime.studios),
        _buildInfoItem('Aired', anime.aired),
        _buildInfoItem('Status', anime.status),
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

  Widget _buildEpisodesList(BuildContext context, List<Episode> episodes) {
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
              onTap: () {
                // Tambah histori saat episode dipilih
                final historyEntry = HistoryEntry(
                  animeId: widget.animeId,
                  title:
                      context.read<AnimeDetailBloc>().state is AnimeDetailLoaded
                          ? (context.read<AnimeDetailBloc>().state
                                  as AnimeDetailLoaded)
                              .animeDetail
                              .data
                              .title
                          : 'Unknown',
                  episode: episode.episodeId,
                  timestamp: DateTime.now().toIso8601String(),
                );
                context.read<HistoryBloc>().add(AddHistoryEvent(historyEntry));
                _navigateToEpisode(context, episode.episodeId);
              },
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
          color: Colors.black38,
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

  Widget _buildWatchButton(BuildContext context, String episode) {
    return Positioned(
      left: 30,
      right: 30,
      bottom: 30,
      child: GestureDetector(
        onTap: () {
          // Tambah histori saat tombol "Tonton Sekarang" ditekan
          final historyEntry = HistoryEntry(
            animeId: widget.animeId,
            title: context.read<AnimeDetailBloc>().state is AnimeDetailLoaded
                ? (context.read<AnimeDetailBloc>().state as AnimeDetailLoaded)
                    .animeDetail
                    .data
                    .title
                : 'Unknown',
            episode: episode,
            timestamp: DateTime.now().toIso8601String(),
          );
          context.read<HistoryBloc>().add(AddHistoryEvent(historyEntry));
          _navigateToEpisode(context, episode);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            color: kButtonColor,
            alignment: Alignment.center,
            height: 68,
            child: const Text(
              "Tonton Sekarang",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEpisode(BuildContext context, String episodeId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EpisodeDetailScreen(episodeId: episodeId),
      ),
    );
  }
}
