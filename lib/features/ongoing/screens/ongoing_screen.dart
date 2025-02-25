import 'package:flutter/material.dart';
import 'package:flutter_anime/features/ongoing/bloc/ongoing_bloc.dart'; // Impor widget baru
import 'package:flutter_anime/features/ongoing/widgets/card_ongoing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreOngoingScreen extends StatefulWidget {
  const MoreOngoingScreen({super.key});

  @override
  State<MoreOngoingScreen> createState() => _MoreOngoingScreenState();
}

class _MoreOngoingScreenState extends State<MoreOngoingScreen> {
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    context.read<OngoingBloc>().add(FetchOngoingAnimeEvent(page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Ongoing Anime'),
      ),
      body: BlocBuilder<OngoingBloc, OngoingState>(
        builder: (context, state) {
          if (state is OngoingLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OngoingLoadedState) {
            final ongoingAnimeList = state.ongoingAnimeResponse.animeList;
            final pagination = state.ongoingAnimeResponse.pagination;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16), // Padding untuk ListView
                    itemCount: ongoingAnimeList.length,
                    itemBuilder: (context, index) {
                      final anime = ongoingAnimeList[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 8), // Margin bawah antar item
                        child: OngoingCard(anime: anime), // Gunakan widget baru
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
                              context.read<OngoingBloc>().add(
                                  FetchOngoingAnimeEvent(page: currentPage));
                            },
                            child: const Text('Previous'),
                          ),
                        if (pagination.hasNextPage)
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                currentPage = pagination.nextPage!;
                              });
                              context.read<OngoingBloc>().add(
                                  FetchOngoingAnimeEvent(page: currentPage));
                            },
                            child: const Text('Next'),
                          ),
                      ],
                    ),
                  ),
              ],
            );
          } else if (state is OngoingErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Ada Kesalahan'));
          }
        },
      ),
    );
  }
}
