import 'package:flutter/material.dart';
import 'package:flutter_anime/features/genres/bloc/genre_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/genre_bloc.dart';

class GenreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Genres')),
      body: BlocBuilder<GenreBloc, GenreState>(
        builder: (context, state) {
          if (state is GenreLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is GenreLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0, // Jarak antar chip horizontal
                runSpacing: 8.0, // Jarak antar chip vertikal
                children: state.genres.map((genre) {
                  return Chip(
                    label: Text(genre.title),
                    // backgroundColor: Colors.blue.shade200,
                  );
                }).toList(),
              ),
            );
          } else if (state is GenreError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Tidak ada data.'));
        },
      ),
    );
  }
}
