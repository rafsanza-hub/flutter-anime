class GenreResponse {
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final GenreData data;
  final dynamic pagination;

  GenreResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      statusCode: json['statusCode'],
      statusMessage: json['statusMessage'],
      message: json['message'],
      ok: json['ok'],
      data: GenreData.fromJson(json['data']),
      pagination: json['pagination'],
    );
  }
}

class GenreData {
  final List<Genre> genreList;

  GenreData({
    required this.genreList,
  });

  factory GenreData.fromJson(Map<String, dynamic> json) {
    return GenreData(
      genreList: (json['genreList'] as List)
          .map((item) => Genre.fromJson(item))
          .toList(),
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
      title: json['title'],
      genreId: json['genreId'],
      href: json['href'],
      otakudesuUrl: json['otakudesuUrl'],
    );
  }
}