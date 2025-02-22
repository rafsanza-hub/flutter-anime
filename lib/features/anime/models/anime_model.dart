class HomeResponse {
  final List<Anime> ongoingAnimeList;
  final List<Anime> completedAnimeList;

  HomeResponse({
    required this.ongoingAnimeList,
    required this.completedAnimeList,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      ongoingAnimeList: (json['data']['ongoing']['animeList'] as List)
          .map((item) => Anime.fromJson(item))
          .toList(),
      completedAnimeList: (json['data']['completed']['animeList'] as List)
          .map((item) => Anime.fromJson(item))
          .toList(),
    );
  }
}

class Anime {
  final String title;
  final String poster;
  final int episodes;
  final String releaseDay;
  final String latestReleaseDate;
  final String animeId;
  final String href;
  final String otakudesuUrl;
  final String? score; // Field opsional
  final String? lastReleaseDate; // Field opsional

  Anime({
    required this.title,
    required this.poster,
    required this.episodes,
    required this.releaseDay,
    required this.latestReleaseDate,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
    this.score,
    this.lastReleaseDate,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      title: json['title'],
      poster: json['poster'],
      episodes: json['episodes'],
      releaseDay: json['releaseDay'],
      latestReleaseDate: json['latestReleaseDate'],
      animeId: json['animeId'],
      href: json['href'],
      otakudesuUrl: json['otakudesuUrl'],
      score: json['score'], // Opsional
      lastReleaseDate: json['lastReleaseDate'], // Opsional
    );
  }

  static List<Anime> listFromJson(List<dynamic> json) {
    return json.map((anime) => Anime.fromJson(anime)).toList();
  }
} 