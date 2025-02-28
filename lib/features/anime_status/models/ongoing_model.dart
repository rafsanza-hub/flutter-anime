import '../../anime/models/anime_model.dart';

class StatusAnimeResponse {
  final List<OngoingAnime> animeList;
  final Pagination pagination;

  StatusAnimeResponse({
    required this.animeList,
    required this.pagination,
  });

  factory StatusAnimeResponse.fromJson(Map<String, dynamic> json) {
    return StatusAnimeResponse(
      animeList: (json['data']['animeList'] as List)
          .map((item) => OngoingAnime.fromJson(item))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
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
      currentPage: json['currentPage'],
      hasPrevPage: json['hasPrevPage'],
      prevPage: json['prevPage'],
      hasNextPage: json['hasNextPage'],
      nextPage: json['nextPage'],
      totalPages: json['totalPages'],
    );
  }
}
