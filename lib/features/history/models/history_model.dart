
class HistoryEntry {
  final String animeId;
  final String title;
  final String episode; 
  final String timestamp;

  HistoryEntry({
    required this.animeId,
    required this.title,
    required this.episode,
    required this.timestamp,
  });

  factory HistoryEntry.fromJson(Map<String, dynamic> json) {
    return HistoryEntry(
      animeId: json['animeid'],
      title: json['title'],
      episode: json['episode'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'animeid': animeId,
      'title': title,
      'episode': episode, // episodeId langsung
      'timestamp': timestamp,
    };
  }
}