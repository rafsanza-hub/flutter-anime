class AnimeDetailResponse {
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final AnimeDetail data;
  final Map<String, dynamic>? pagination;

  AnimeDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory AnimeDetailResponse.fromJson(Map<String, dynamic> json) {
    return AnimeDetailResponse(
      statusCode: json['statusCode'] as int? ?? 0, 
      statusMessage: json['statusMessage'] as String? ?? '',
      message: json['message'] as String? ?? '',
      ok: json['ok'] as bool? ?? false,
      data: AnimeDetail.fromJson(json['data'] as Map<String, dynamic>),
      pagination: json['pagination'] as Map<String, dynamic>?,
    );
  }
}

class AnimeDetail {
  final String title;
  final String poster;
  final String japanese;
  final String score;
  final String producers;
  final String status;
  final int episodes;
  final String duration;
  final String aired;
  final String studios;
  final Batch? batch; // opsional
  final Synopsis synopsis;
  final List<Genre> genreList;
  final List<Episode> episodeList;
  final List<RecommendedAnime> recommendedAnimeList;

  AnimeDetail({
    required this.title,
    required this.poster,
    required this.japanese,
    required this.score,
    required this.producers,
    required this.status,
    required this.episodes,
    required this.duration,
    required this.aired,
    required this.studios,
    this.batch, // opsional
    required this.synopsis,
    required this.genreList,
    required this.episodeList,
    required this.recommendedAnimeList,
  });

  factory AnimeDetail.fromJson(Map<String, dynamic> json) {
    return AnimeDetail(
      title: json['title'] as String? ?? '',
      poster: json['poster'] as String? ?? '',
      japanese: json['japanese'] as String? ?? '',
      score: json['score'] as String? ?? '',
      producers: json['producers'] as String? ?? '',
      status: json['status'] as String? ?? '',
      episodes: json['episodes'] as int? ?? 0,
      duration: json['duration'] as String? ?? '',
      aired: json['aired'] as String? ?? '',
      studios: json['studios'] as String? ?? '',
      batch: json['batch'] != null ? Batch.fromJson(json['batch']) : null, // handle null
      synopsis: Synopsis.fromJson(json['synopsis'] as Map<String, dynamic>),
      genreList: (json['genreList'] as List?)
              ?.map((item) => Genre.fromJson(item))
              .toList() ??
          [], // Handle null
      episodeList: (json['episodeList'] as List?)
              ?.map((item) => Episode.fromJson(item))
              .toList() ??
          [], // Handle null
      recommendedAnimeList: (json['recommendedAnimeList'] as List?)
              ?.map((item) => RecommendedAnime.fromJson(item))
              .toList() ??
          [], // Handle null
    );
  }
}

class Batch {
  final String title;
  final String batchId;
  final String href;
  final String otakudesuUrl;

  Batch({
    required this.title,
    required this.batchId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      title: json['title'] as String? ?? '',
      batchId: json['batchId'] as String? ?? '',
      href: json['href'] as String? ?? '',
      otakudesuUrl: json['otakudesuUrl'] as String? ?? '',
    );
  }
}

class Synopsis {
  final List<String> paragraphs;
  final List<dynamic> connections;

  Synopsis({
    required this.paragraphs,
    required this.connections,
  });

  factory Synopsis.fromJson(Map<String, dynamic> json) {
    return Synopsis(
      paragraphs: (json['paragraphs'] as List?)?.map((e) => e.toString()).toList() ?? [],
      connections: json['connections'] as List<dynamic>? ?? [],
    );
  }
}

class Genre {
  final String title;
  final String genreId;
  final String href;
  final String otakudesuUrl;

  Genre({
    required this.title,
    required this.genreId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      title: json['title'] as String? ?? '',
      genreId: json['genreId'] as String? ?? '',
      href: json['href'] as String? ?? '',
      otakudesuUrl: json['otakudesuUrl'] as String? ?? '',
    );
  }
}

class Episode {
  final int title;
  final String episodeId;
  final String href;
  final String otakudesuUrl;

  Episode({
    required this.title,
    required this.episodeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      title: json['title'] as int? ?? 0,
      episodeId: json['episodeId'] as String? ?? '',
      href: json['href'] as String? ?? '',
      otakudesuUrl: json['otakudesuUrl'] as String? ?? '',
    );
  }
}

class RecommendedAnime {
  final String title;
  final String poster;
  final String animeId;
  final String href;
  final String otakudesuUrl;

  RecommendedAnime({
    required this.title,
    required this.poster,
    required this.animeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory RecommendedAnime.fromJson(Map<String, dynamic> json) {
    return RecommendedAnime(
      title: json['title'] as String? ?? '',
      poster: json['poster'] as String? ?? '',
      animeId: json['animeId'] as String? ?? '',
      href: json['href'] as String? ?? '',
      otakudesuUrl: json['otakudesuUrl'] as String? ?? '',
    );
  }
}