import 'package:flutter/material.dart';
import '../models/anime_model.dart';

class CustomCardNormal extends StatelessWidget {
  final Anime anime;

  const CustomCardNormal({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image Container
        Container(
          height: 180,
          width: 120,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(anime.poster),
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
          left: 7,
          top: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '${anime.episodes} Eps',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Anime Title
        Positioned(
          left: 4,
          right: 4,
          bottom: 8,
          child: Text(
            anime.title,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 3.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
