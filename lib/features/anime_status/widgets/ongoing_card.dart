import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../anime/models/anime_model.dart';

class OngoingCard extends StatelessWidget {
  final OngoingAnime anime;

  const OngoingCard({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Anime (Card Bersih)
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: anime.poster,
              width: 130,
              height: 180,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[900],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[900],
                child: const Icon(Icons.error, color: Colors.white54),
              ),
            ),
          ),

          const SizedBox(width: 12), // Spasi antara gambar dan teks

          // Informasi Anime (Di Sisi Card)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Judul Anime
                Text(
                  anime.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8), // Spasi kecil

                // Hari Rilis
                Text(
                  'Hari Rilis: ${anime.releaseDay}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4), // Spasi kecil

                // Jumlah Episode
                Text(
                  'Episode: ${anime.episodes}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4), // Spasi kecil

                // Rilis Terakhir
                Text(
                  'Rilis Terakhir: ${anime.latestReleaseDate}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
