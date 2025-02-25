import 'package:flutter/material.dart';
import 'package:flutter_anime/features/anime/models/anime_model.dart';

class CustomCardNormal extends StatelessWidget {
  final Anime anime;

  const CustomCardNormal({
    Key? key,
    required this.anime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image Container
        Container(
          height: 200,
          width: 140,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(anime.poster), // poster
              fit: BoxFit.cover,
            ),
          ),
          // Overlay gradient
          foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.8),
              ],
              stops: const [0.5, 0.8, 1.0],
            ),
          ),
        ),

        // Episode Count Badge
        Positioned(
          left: 15,
          top: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${anime.episodes} Eps',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Anime Title
        Positioned(
          left: 12,
          right: 12,
          bottom: 12,
          child: Text(
            anime.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                    offset: Offset(0, 1), blurRadius: 3.0, color: Colors.black),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
