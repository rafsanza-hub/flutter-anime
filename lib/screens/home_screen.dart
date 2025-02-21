import 'package:flutter/material.dart';
import 'package:flutter_anime/blocs/anime/anime_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/anime_model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Anime'),
      ),
      body: BlocBuilder<AnimeBloc, AnimeState>(
        builder: (context, state) {
          if (state is AnimeLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AnimeLoadedState) {
            final ongoingAnimeList = state.animeList;
            final completedAnimeList = state.animeList;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Ongoing Anime',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildAnimeList(ongoingAnimeList),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Completed Anime',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildAnimeList(completedAnimeList),
                ],
              ),
            );
          } else if (state is AnimeErrorState) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('Tekan tombol untuk memuat data'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AnimeBloc>().add(FetchAnimeEvent()); // triger
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildAnimeList(List<Anime> animeList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: animeList.length,
      itemBuilder: (context, index) {
        Anime anime = animeList[index];
        return ListTile(
          leading: Image.network(anime.poster, fit: BoxFit.cover),
          title: Text(anime.title),
          subtitle: Text(
              'Episode: ${anime.episodes} | Rilis: ${anime.latestReleaseDate}'),
          onTap: () {},
        );
      },
    );
  }
}
