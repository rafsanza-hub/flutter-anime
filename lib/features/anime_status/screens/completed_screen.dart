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
  final ScrollController _scrollController = ScrollController();
  late final CompletedBloc completedBloc;
  int currentPage = 1;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    completedBloc = context.read<CompletedBloc>();
    completedBloc.add(FetchCompletedAnimeEvent(page: currentPage));
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
    completedBloc.add(FetchCompletedAnimeEvent(page: currentPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Completed Anime'),
      ),
      body: BlocConsumer<CompletedBloc, CompletedState>(
        listener: (context, state) {
          if (state is CompletedLoadedState) {
            setState(() {
              isLoadingMore = false;
            });
          }
        },
        builder: (context, state) {
          if (state is CompletedLoadingState && currentPage == 1) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompletedLoadedState) {
            final completedAnimeList = state.completedAnimeResponse.animeList;
            final pagination = state.completedAnimeResponse.pagination;

            if (completedAnimeList.isEmpty) {
              return const Center(
                child: Text(
                  'Tidak ada anime completed',
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
                completedBloc.add(FetchCompletedAnimeEvent(page: currentPage));
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: completedAnimeList.length +
                    (pagination.hasNextPage ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == completedAnimeList.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final anime = completedAnimeList[index];
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
                      child: CompletedCard(anime: anime),
                    ),
                  );
                },
              ),
            );
          } else if (state is CompletedErrorState) {
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
                      completedBloc
                          .add(FetchCompletedAnimeEvent(page: currentPage));
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
