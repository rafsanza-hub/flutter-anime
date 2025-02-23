import 'package:better_player_enhanced/better_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl; // URL video yang akan diputar
  final bool autoPlay; // Opsi untuk memutar video secara otomatis
  final bool looping; // Opsi untuk mengulang video

  const VideoPlayerWidget({
    required this.videoUrl,
    this.autoPlay = true,
    this.looping = false,
    Key? key,
  }) : super(key: key);
  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    // Konfigurasi data source untuk video
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );
    print("lalalalala"+widget.videoUrl);

    // Konfigurasi pemutar video
    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        autoPlay: widget.autoPlay, // Memutar video secara otomatis
        looping: widget.looping, // Mengulang video
        aspectRatio: 16 / 9, // Rasio aspek video
        fit: BoxFit.contain, // Menyesuaikan video ke dalam container
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableSkips: true, // Mengaktifkan tombol skip

          enableFullscreen: true, // Mengaktifkan mode fullscreen
          enableMute: true, // Mengaktifkan tombol mute
          enableProgressText: true, // Menampilkan durasi video
          enableProgressBar: true, // Menampilkan progress bar
        ),
      ),
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Rasio aspek container
      child: BetterPlayer(
        controller: _betterPlayerController,
      ),
    );
  }

  @override
  void dispose() {
    // Membersihkan controller saat widget dihapus
    _betterPlayerController.dispose();
    super.dispose();
  }
}
