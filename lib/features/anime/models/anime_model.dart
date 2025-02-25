class AnimeList {
  final List<OngoingAnime> ongoing;
  final List<CompletedAnime> completed;

  AnimeList({
    required this.ongoing,
    required this.completed,
  });

  factory AnimeList.fromJson(Map<String, dynamic> json) {
    return AnimeList(
      ongoing: (json['data']['ongoing']['animeList'] as List)
          .map((item) => OngoingAnime.fromJson(item))
          .toList(),
      completed: (json['data']['completed']['animeList'] as List)
          .map((item) => CompletedAnime.fromJson(item))
          .toList(),
    );
  }
}

// Class dasar untuk properti umum anime
abstract class Anime {
  final String title;
  final String poster;
  final int episodes;
  final String animeId;
  final String href;
  final String otakudesuUrl;
  final String? score; // Field opsional

  Anime({
    required this.title,
    required this.poster,
    required this.episodes,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
    this.score,
  });
}

// Class untuk anime yang masih ongoing
class OngoingAnime extends Anime {
  final String? releaseDay;
  final String? latestReleaseDate;
  final String? lastReleaseDate;

  OngoingAnime({
    required super.title,
    required super.poster,
    required super.episodes,
    this.releaseDay,
    this.latestReleaseDate,
    required this.lastReleaseDate,
    required super.animeId,
    required super.href,
    required super.otakudesuUrl,
    super.score,
  });

  factory OngoingAnime.fromJson(Map<String, dynamic> json) {
    return OngoingAnime(
      title: json['title'],
      poster: json['poster'],
      episodes: json['episodes'],
      releaseDay: json['releaseDay'],
      latestReleaseDate: json['latestReleaseDate'],
      lastReleaseDate: json['lastReleaseDate'],
      animeId: json['animeId'],
      href: json['href'],
      otakudesuUrl: json['otakudesuUrl'],
      score: json['score'],
    );
  }

  static List<OngoingAnime> listFromJson(List<dynamic> json) {
    return json.map((anime) => OngoingAnime.fromJson(anime)).toList();
  }
}

// Class untuk anime yang sudah completed
class CompletedAnime extends Anime {
  final String lastReleaseDate;

  CompletedAnime({
    required super.title,
    required super.poster,
    required super.episodes,
    required this.lastReleaseDate,
    required super.animeId,
    required super.href,
    required super.otakudesuUrl,
    super.score,
  });

  factory CompletedAnime.fromJson(Map<String, dynamic> json) {
    return CompletedAnime(
      title: json['title'],
      poster: json['poster'],
      episodes: json['episodes'],
      lastReleaseDate: json['lastReleaseDate'],
      animeId: json['animeId'],
      href: json['href'],
      otakudesuUrl: json['otakudesuUrl'],
      score: json['score'],
    );
  }

  static List<CompletedAnime> listFromJson(List<dynamic> json) {
    return json.map((anime) => CompletedAnime.fromJson(anime)).toList();
  }
}
