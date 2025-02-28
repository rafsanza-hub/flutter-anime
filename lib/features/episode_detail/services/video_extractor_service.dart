import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class VideoExtractorService {
  static Future<String?> extractVideoUrl(String pageUrl) async {
    try {
      print('Fetching embed page: $pageUrl');

      final response = await http.get(Uri.parse(pageUrl));

      if (response.statusCode == 200) {
        final document = parser.parse(response.body);

        // Cari elemen `<meta property="og:video" content="URL">`
        final metaTags = document.getElementsByTagName('meta');
        for (var meta in metaTags) {
          if (meta.attributes['property'] == 'og:video') {
            final videoUrl = meta.attributes['content'];
            if (videoUrl != null && videoUrl.startsWith('http')) {
              print('Direct video URL ditemukan: $videoUrl');
              return videoUrl;
            }
          }
        }
      }
    } catch (e) {
    }
    return null;
  }
}
