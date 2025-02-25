// lib/features/home/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/models/anime_model.dart';
import 'package:flutter_anime/features/anime/widgets/custom_card_normal.dart';
import 'package:flutter_anime/features/anime/widgets/persegi_card.dart';
import 'package:flutter_anime/features/anime_detail/screens/anime_detail_screen.dart';
import 'package:flutter_anime/features/anime_status/screens/completed_screen.dart';
import 'package:flutter_anime/features/anime_status/screens/ongoing_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/colors.dart';
import '../../anime/bloc/anime_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<AnimeBloc, AnimeState>(
          builder: (context, state) {
            if (state is AnimeLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AnimeLoadedState) {
              final ongoingAnimeList = state.animeList.ongoing;
              final completedAnimeList = state.animeList.completed;

              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeaderSection(),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: SearchSection(),
                    ),
                    const SizedBox(height: 20),
                    AnimeCardsSection(
                      ongoingAnime: ongoingAnimeList,
                      completedAnime: completedAnimeList,
                    ),
                  ],
                ),
              );
            } else if (state is AnimeErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Ada Kesalahan'));
            }
          },
        ),
      ),
    );
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
        _buildSectionTitle(context, "Ongoing"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _buildAnimeListHorizontal(context, ongoingAnime),
        ),
        _buildSectionTitle(context, "Completed"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _buildAnimeGrid(context, completedAnime),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (title == "Ongoing")
                        ? (context) => const MoreOngoingScreen()
                        : (context) => const MoreCompletedScreen()),
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

  Widget _buildAnimeListHorizontal(
      BuildContext context, List<Anime> animeList) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      height: MediaQuery.of(context).size.height * 0.21,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: animeList.length,
        scrollDirection: Axis.horizontal,
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
      ),
    );
  }

  Widget _buildAnimeGrid(BuildContext context, List<Anime> animeList) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
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
          child: PersegiCard(
            anime: animeList[index],
          ),
        );
      },
    );
  }
}

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kSearchbarColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search_rounded,
            color: Colors.white30,
          ),
          SizedBox(width: 20),
          Text(
            "Search anime",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
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

  Widget _buildProfileAvatar() {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          image: NetworkImage(
            "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=387&q=80",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
