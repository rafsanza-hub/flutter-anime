import 'package:flutter/material.dart';
import '../../anime_detail/screens/anime_detail_screen.dart';
import '../bloc/ongoing/ongoing_bloc.dart';
import '../widgets/ongoing_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreOngoingScreen extends StatefulWidget {
  const MoreOngoingScreen({super.key});

  @override
  State<MoreOngoingScreen> createState() => _MoreOngoingScreenState();
}

class _MoreOngoingScreenState extends State<MoreOngoingScreen> {
  final ScrollController _scrollController = ScrollController();
  late final OngoingBloc ongoingBloc;
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    ongoingBloc = context.read<OngoingBloc>();
    ongoingBloc.add(FetchOngoingAnimeEvent(page: currentPage));
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
    ongoingBloc.add(FetchOngoingAnimeEvent(page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lagi ongoing'),
      ),
      body: BlocConsumer<OngoingBloc, OngoingState>(
        listener: (context, state) {
          if (state is OngoingLoadedState) {
            setState(() {
              isLoadingMore = false;
            });
          }
        },
        builder: (context, state) {
          if (state is OngoingLoadingState && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is OngoingLoadedState) {
            final ongoingAnimeList = state.ongoingAnimeResponse.animeList;
            final pagination = state.ongoingAnimeResponse.pagination;

            if (ongoingAnimeList.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada anime ongoing',
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
                ongoingBloc.add(FetchOngoingAnimeEvent(page: currentPage));
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount:
                    ongoingAnimeList.length + (pagination.hasNextPage ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == ongoingAnimeList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final anime = ongoingAnimeList[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
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
                      child: OngoingCard(anime: anime),
                    ),
                  );
                },
              ),
            );
          } else if (state is OngoingErrorState) {
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
                      ongoingBloc
                          .add(FetchOngoingAnimeEvent(page: currentPage));
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
}
