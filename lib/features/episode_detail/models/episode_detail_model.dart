class EpisodeDetailResponse {
  final int statusCode;
  final String statusMessage;
  final String message;
  final bool ok;
  final EpisodeDetail data;
  final dynamic pagination;

  EpisodeDetailResponse({
    required this.statusCode,
    required this.statusMessage,
    required this.message,
    required this.ok,
    required this.data,
    this.pagination,
  });

  factory EpisodeDetailResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeDetailResponse(
      statusCode: json['statusCode'] as int? ?? 0,
      statusMessage: json['statusMessage'] as String? ?? '',
      message: json['message'] as String? ?? '',
      ok: json['ok'] as bool? ?? false,
      data: EpisodeDetail.fromJson(json['data'] as Map<String, dynamic>),
      pagination: json['pagination'],
    );
  }
}

class EpisodeDetail {
  final String title;
  final String animeId;
  final String releaseTime;
   String defaultStreamingUrl;
  final bool hasPrevEpisode;
  final EpisodeNavigation? prevEpisode;
  final bool hasNextEpisode;
  final EpisodeNavigation? nextEpisode;
  final Server server;
  final DownloadUrl downloadUrl;
  final EpisodeInfo info;

  EpisodeDetail({
    required this.title,
    required this.animeId,
    required this.releaseTime,
    required this.defaultStreamingUrl,
    required this.hasPrevEpisode,
    this.prevEpisode,
    required this.hasNextEpisode,
    this.nextEpisode,
    required this.server,
    required this.downloadUrl,
    required this.info,
  });

  factory EpisodeDetail.fromJson(Map<String, dynamic> json) {
    return EpisodeDetail(
      title: json['title'] as String? ?? '',
      animeId: json['animeId'] as String? ?? '',
      releaseTime: json['releaseTime'] as String? ?? '',
      defaultStreamingUrl: json['defaultStreamingUrl'] as String? ?? '',
      hasPrevEpisode: json['hasPrevEpisode'] as bool? ?? false,
      prevEpisode: json['prevEpisode'] != null
          ? EpisodeNavigation.fromJson(json['prevEpisode'])
          : null,
      hasNextEpisode: json['hasNextEpisode'] as bool? ?? false,
      nextEpisode: json['nextEpisode'] != null
          ? EpisodeNavigation.fromJson(json['nextEpisode'])
          : null,
      server: Server.fromJson(json['server'] as Map<String, dynamic>),
      downloadUrl: DownloadUrl.fromJson(json['downloadUrl'] as Map<String, dynamic>),
      info: EpisodeInfo.fromJson(json['info'] as Map<String, dynamic>),
    );
  }
}

class EpisodeNavigation {
  final String title;
  final String episodeId;
  final String href;
  final String otakudesuUrl;

  EpisodeNavigation({
    required this.title,
    required this.episodeId,
    required this.href,
    required this.otakudesuUrl,
  });

  factory EpisodeNavigation.fromJson(Map<String, dynamic> json) {
    return EpisodeNavigation(
      title: json['title']?.toString() ?? '', // Handle int or String
      episodeId: json['episodeId'] as String? ?? '',
      href: json['href'] as String? ?? '',
      otakudesuUrl: json['otakudesuUrl'] as String? ?? '',
    );
  }
}

class Server {
  final List<Quality> qualities;

  Server({
    required this.qualities,
  });

  factory Server.fromJson(Map<String, dynamic> json) {
    return Server(
      qualities: (json['qualities'] as List?)
              ?.map((item) => Quality.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class Quality {
  final String title;
  final List<ServerItem> serverList;

  Quality({
    required this.title,
    required this.serverList,
  });

  factory Quality.fromJson(Map<String, dynamic> json) {
    return Quality(
      title: json['title'] as String? ?? '',
      serverList: (json['serverList'] as List?)
              ?.map((item) => ServerItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class ServerItem {
  final String title;
  final String serverId;
  final String href;

  ServerItem({
    required this.title,
    required this.serverId,
    required this.href,
  });

  factory ServerItem.fromJson(Map<String, dynamic> json) {
    return ServerItem(
      title: json['title'] as String? ?? '',
      serverId: json['serverId'] as String? ?? '',
      href: json['href'] as String? ?? '',
    );
  }
}

class DownloadUrl {
  final List<DownloadQuality> qualities;

  DownloadUrl({
    required this.qualities,
  });

  factory DownloadUrl.fromJson(Map<String, dynamic> json) {
    return DownloadUrl(
      qualities: (json['qualities'] as List?)
              ?.map((item) => DownloadQuality.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class DownloadQuality {
  final String title;
  final String size;
  final List<DownloadLink> urls;

  DownloadQuality({
    required this.title,
    required this.size,
    required this.urls,
  });

  factory DownloadQuality.fromJson(Map<String, dynamic> json) {
    return DownloadQuality(
      title: json['title'] as String? ?? '',
      size: json['size'] as String? ?? '',
      urls: (json['urls'] as List?)
              ?.map((item) => DownloadLink.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class DownloadLink {
  final String title;
  final String url;

  DownloadLink({
    required this.title,
    required this.url,
  });

  factory DownloadLink.fromJson(Map<String, dynamic> json) {
    return DownloadLink(
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
    );
  }
}

class EpisodeInfo {
  final String credit;
  final String encoder;
  final String duration;
  final String type;
  final List<Genre> genreList;
  final List<EpisodeNavigation> episodeList;

  EpisodeInfo({
    required this.credit,
    required this.encoder,
    required this.duration,
    required this.type,
    required this.genreList,
    required this.episodeList,
  });

  factory EpisodeInfo.fromJson(Map<String, dynamic> json) {
    return EpisodeInfo(
      credit: json['credit'] as String? ?? '',
      encoder: json['encoder'] as String? ?? '',
      duration: json['duration'] as String? ?? '',
      type: json['type'] as String? ?? '',
      genreList: (json['genreList'] as List?)
              ?.map((item) => Genre.fromJson(item))
              .toList() ??
          [],
      episodeList: (json['episodeList'] as List?)
              ?.map((item) => EpisodeNavigation.fromJson(item))
              .toList() ??
          [],
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