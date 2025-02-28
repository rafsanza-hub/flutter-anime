class HistoryEntry {
  final String animeId;
  final String title;
  final String episode;
  final String timestamp;
  final String poster;

  HistoryEntry({
    required this.animeId,
    required this.title,
    required this.episode,
    required this.timestamp,
    required this.poster,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      animeId: json['anime_id'],
      title: json['title'],
      episode: json['episode_id'],
      timestamp: json['timestamp'],
      poster: json['poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'anime_id': animeId,
      'title': title,
      'episode_id': episode, // episodeId langsung
      'timestamp': timestamp,
      'poster': poster,
    };
  }
}
