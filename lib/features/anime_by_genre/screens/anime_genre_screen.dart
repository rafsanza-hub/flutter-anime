import 'package:flutter/material.dart';
import '../bloc/anime_genre_bloc.dart';
import '../bloc/anime_genre_event.dart';
import '../bloc/anime_genre_state.dart';
import '../models/anime_genre_model.dart';
import '../../anime_detail/screens/anime_detail_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AnimeGenreScreen extends StatefulWidget {
  final String genreId;
  const AnimeGenreScreen({super.key, required this.genreId});

  @override
  State<AnimeGenreScreen> createState() => _AnimeGenreScreenState();
}

class _AnimeGenreScreenState extends State<AnimeGenreScreen> {
  final ScrollController _scrollController = ScrollController();
  late final AnimeGenreBloc animeGenreBloc;
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    animeGenreBloc = context.read<AnimeGenreBloc>();
    animeGenreBloc
        .add(FetchAnimeGenreEvent(genreId: widget.genreId, page: currentPage));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !isLoadingMore) {
      _loadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  void _loadMore() {
    if (isLoadingMore) return;
    setState(() {
      isLoadingMore = true;
    });
    currentPage++;
    animeGenreBloc
        .add(FetchAnimeGenreEvent(genreId: widget.genreId, page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime by Genre'),
      ),
      body: BlocConsumer<AnimeGenreBloc, AnimeGenreState>(
        listener: (context, state) {
          if (state is AnimeGenreLoaded) {
            setState(() {
              isLoadingMore = false;
            });
          }
        },
        builder: (context, state) {
          if (state is AnimeGenreLoading && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnimeGenreLoaded) {
            final animeList = state.response.animeList;
            final pagination = state.response.pagination;

            if (animeList.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada anime untuk genre ini',
                  style: TextStyle(color: Colors.white54),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  currentPage = 1;
                  isLoadingMore = false;
                });
                animeGenreBloc.add(FetchAnimeGenreEvent(
                    genreId: widget.genreId, page: currentPage));
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: animeList.length + (pagination.hasNextPage ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == animeList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final anime = animeList[index];
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
              ),
            );
          } else if (state is AnimeGenreError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: const TextStyle(color: Colors.white54),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                        isLoadingMore = false;
                      });
                      animeGenreBloc.add(FetchAnimeGenreEvent(
                          genreId: widget.genreId, page: currentPage));
                    },
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: Text(
              'Ada Kesalahan',
              style: TextStyle(color: Colors.white54),
            ),
          );
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
            child: CachedNetworkImage(
              imageUrl: anime.poster,
              width: 130,
              height: 180,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[900],
                child: const Icon(Icons.error, color: Colors.white54),
              ),
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
