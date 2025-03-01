import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/models/anime_model.dart';
import 'package:flutter_anime/features/anime/widgets/custom_card_normal.dart';
import 'package:flutter_anime/features/anime/widgets/custom_card_thumbnail.dart';
import 'package:flutter_anime/features/anime_detail/screens/anime_detail_screen.dart';
import 'package:flutter_anime/features/anime_status/screens/completed_screen.dart';
import 'package:flutter_anime/features/anime_status/screens/ongoing_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/colors.dart';
import '../bloc/anime_bloc.dart';
import '../../../features/search/screens/search_screen.dart';
import '../../genre/bloc/genre_bloc.dart';
import '../../genre/bloc/genre_state.dart';
import '../../anime_by_genre/screens/anime_genre_screen.dart';
import '../../history/bloc/history_bloc.dart';
import '../../episode_detail/screens/episode_detail_screen.dart';
import '../../history/screens/history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AnimeBloc animeBloc;

  @override
  void initState() {
    super.initState();
    animeBloc = BlocProvider.of<AnimeBloc>(context);
    animeBloc.add(FetchAnimeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<AnimeBloc, AnimeState>(
          bloc: animeBloc,
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hi, Rafsan",
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
                  const SizedBox(height: 20),
                  _buildContent(state),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(AnimeState state) {
    if (state is AnimeLoadingState) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is AnimeLoadedState) {
      return Column(
        children: [
          AnimeCardsSection(
            ongoingAnime: state.animeList.ongoing,
            completedAnime: state.animeList.completed,
          ),
          const SizedBox(height: 100),
        ],
      );
    } else if (state is AnimeErrorState) {
      return Center(child: Text(state.message));
    }
    return const Center(child: Text('Ada Kesalahan'));
  }
}

class AnimeCardsSection extends StatelessWidget {
  final List<Anime> ongoingAnime;
  final List<Anime> completedAnime;

  const AnimeCardsSection({
    super.key,
    required this.ongoingAnime,
    required this.completedAnime,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, "Terakhir dilihat"),
        _buildHistorySection(context),
        _buildSectionTitle(context, "Ongoing"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildOngoingGrid(context, ongoingAnime),
        ),
        _buildSectionTitle(context, "Genre pilihan"),
        _buildGenreChips(context),
        _buildSectionTitle(context, "Completed"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildAnimeGrid(context, completedAnime),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            context.read<HistoryBloc>().add(FetchHistoryEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            if (state.history.isEmpty) {
              return const Center(
                child: Text(
                  'Belum ada histori',
                  style: TextStyle(color: Colors.white54),
                ),
              );
            }
            final entry = state.history.first;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(entry.poster),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        entry.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EpisodeDetailScreen(
                                episodeId: entry.episode,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.play_circle_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                        label: const Text(
                          'Lanjutkan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black26,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildOngoingGrid(BuildContext context, List<Anime> animeList) {
    final limitedList = animeList.take(6).toList();
    return Container(
      height: 180,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: limitedList.length,
        itemBuilder: (context, index) {
          return Container(
            width: (MediaQuery.of(context).size.width - 48) / 3,
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AnimeDetailScreen(animeId: limitedList[index].animeId),
                  ),
                );
              },
              child: CustomCardNormal(
                anime: limitedList[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (title == "Completed" || title == "Ongoing")
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (title == "Ongoing")
                        ? (context) => const MoreOngoingScreen()
                        : (context) => const MoreCompletedScreen(),
                  ),
                );
              },
              child: const Text(
                "See all",
                style: TextStyle(
                  color: kButtonColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          if (title == "History")
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
              child: const Text(
                "See all",
                style: TextStyle(
                  color: kButtonColor,
                  fontSize: 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAnimeGrid(BuildContext context, List<Anime> animeList) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 12,
      ),
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AnimeDetailScreen(animeId: animeList[index].animeId),
              ),
            );
          },
          child: CustomCardNormal(
            anime: animeList[index],
          ),
        );
      },
    );
  }

  Widget _buildGenreChips(BuildContext context) {
    return Container(
      height: 36,
      margin: const EdgeInsets.only(bottom: 8),
      child: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is GenreLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: state.genres.length,
              itemBuilder: (context, index) {
                final genre = state.genres[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    backgroundColor: kSearchbarColor,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    label: Text(
                      genre.title,
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 12,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnimeGenreScreen(
                            genreId: genre.genreId,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Hi, Rafsan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          // _buildProfileAvatar(),
        ],
      ),
    );
  }
}
