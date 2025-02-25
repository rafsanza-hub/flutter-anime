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

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'genreId': genreId,
      'href': href,
      'otakudesuUrl': otakudesuUrl,
    };
  }
}

class GenreResponse {
  final List<Genre> genres;

  GenreResponse({required this.genres});

  factory GenreResponse.fromJson(Map<String, dynamic> json) {
    return GenreResponse(
      genres: (json['data']['genreList'] as List)
          .map((item) => Genre.fromJson(item))
          .toList(),
    );
  }
}
