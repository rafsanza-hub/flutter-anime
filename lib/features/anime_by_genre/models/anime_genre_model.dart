class Anime {
  final String title;
  final String poster;
  final String studios;
  final String score;
  final int? episodes;
  final String season;
  final String animeId;
  final String otakudesuUrl;
  final List<String> synopsis;
  final List<String> genres;

  Anime({
    required this.title,
    required this.poster,
    required this.studios,
    required this.score,
    required this.episodes,
    required this.season,
    required this.animeId,
    required this.otakudesuUrl,
    required this.synopsis,
    required this.genres,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title'],
      poster: json['poster'],
      studios: json['studios'],
      score: json['score'],
      episodes: json['episodes'],
      season: json['season'],
      animeId: json['animeId'],
      otakudesuUrl: json['otakudesuUrl'],
      synopsis: List<String>.from(json['synopsis']['paragraphs'] ?? []),
      genres: (json['genreList'] as List)
          .map((genre) => genre['title'].toString())
          .toList(),
    );
  }
}
