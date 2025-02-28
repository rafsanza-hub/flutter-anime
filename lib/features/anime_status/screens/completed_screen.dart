import 'package:flutter/material.dart';
import '../../anime_detail/screens/anime_detail_screen.dart';
import '../bloc/completed/completed_bloc.dart';
import '../widgets/completed_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreCompletedScreen extends StatefulWidget {
  const MoreCompletedScreen({super.key});

  @override
  State<MoreCompletedScreen> createState() => _MoreCompletedScreenState();
}

class _MoreCompletedScreenState extends State<MoreCompletedScreen> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<CompletedBloc>().add(FetchCompletedAnimeEvent(page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Completed Anime'),
      ),
      body: BlocBuilder<CompletedBloc, CompletedState>(
        builder: (context, state) {
          if (state is CompletedLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompletedLoadedState) {
            final completedAnimeList = state.completedAnimeResponse.animeList;
            final pagination = state.completedAnimeResponse.pagination;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16), // Padding untuk ListView
                    itemCount: completedAnimeList.length,
                    itemBuilder: (context, index) {
                      final anime = completedAnimeList[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8), // Margin bawah antar item
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      AnimeDetailScreen(animeId: anime.animeId),
                                ),
                              );
                            },
                            child: CompletedCard(
                              anime: anime,
                            )), // Gunakan widget baru
                      );
                    },
                  ),
                ),
                if (pagination.hasNextPage || pagination.hasPrevPage)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (pagination.hasPrevPage)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage = pagination.prevPage!;
                              });
                              context.read<CompletedBloc>().add(
                                  FetchCompletedAnimeEvent(page: currentPage));
                            },
                            child: const Text('Previous'),
                          ),
                        if (pagination.hasNextPage)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage = pagination.nextPage!;
                              });
                              context.read<CompletedBloc>().add(
                                  FetchCompletedAnimeEvent(page: currentPage));
                            },
                            child: const Text('Next'),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          } else if (state is CompletedErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Ada Kesalahan'));
          }
        },
      ),
    );
  }
}
