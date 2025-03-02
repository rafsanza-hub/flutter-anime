class AnimeGenreResponse {
  final List<Anime> animeList;
  final Pagination pagination;

  AnimeGenreResponse({
    required this.animeList,
    required this.pagination,
  });

  factory AnimeGenreResponse.fromJson(Map<String, dynamic> json) {
    return AnimeGenreResponse(
      animeList: (json['data']['animeList'] as List)
          .map((item) => Anime.fromJson(item))
          .toList(),
      pagination: json.containsKey('pagination')
          ? Pagination.fromJson(json['pagination'])
          : Pagination.empty(),
    );
  }
}

class Pagination {
  final int currentPage;
  final bool hasPrevPage;
  final int? prevPage;
  final bool hasNextPage;
  final int? nextPage;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.hasPrevPage,
    this.prevPage,
    required this.hasNextPage,
    this.nextPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'] ?? 1,
      hasPrevPage: json['hasPrevPage'] ?? false,
      prevPage: json['prevPage'],
      hasNextPage: json['hasNextPage'] ?? false,
      nextPage: json['nextPage'],
      totalPages: json['totalPages'] ?? 1,
    );
  }

  factory Pagination.empty() {
    return Pagination(
      currentPage: 1,
      hasPrevPage: false,
      hasNextPage: false,
      totalPages: 1,
    );
  }
}

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
