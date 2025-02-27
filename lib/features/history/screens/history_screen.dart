import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/history_bloc.dart';
import '../../anime_detail/screens/anime_detail_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histori Anime'),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryInitial) {
            context.read<HistoryBloc>().add(FetchHistoryEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HistoryLoaded) {
            final history = state.history;
            if (history.isEmpty) {
              return const Center(child: Text('Belum ada histori'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];
                return ListTile(
                  title: Text(entry.title),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Episode: ${entry.episode}'),
                      Text('Dilihat pada: ${entry.timestamp}'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimeDetailScreen(animeId: entry.animeId),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is HistoryError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Ada Kesalahan'));
        },
      ),
    );
  }
}