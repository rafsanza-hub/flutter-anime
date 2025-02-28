import 'package:flutter/material.dart';
import '../models/anime_model.dart';
import '../../../utils/colors.dart';

class CustomCardThumbnail extends StatelessWidget {
  final Anime anime;

  const CustomCardThumbnail({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 30),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kButtonColor.withOpacity(0.25),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(anime.poster),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
