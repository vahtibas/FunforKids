import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class YouTubePage extends StatelessWidget {
  final String videoId;

  const YouTubePage({Key? key, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('YouTube'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          onReady: () {},
        ),
      ),
    );
  }
}

class Music {
  String title;
  String videoId;

  Music({required this.title, required this.videoId});
}

class MusicListPage extends StatelessWidget {
  final List<Music> musicList = [
    Music(title: 'Ellerimizi nasıl yıkamalıyız ?', videoId: 'f31cq5bK9i4'),
    Music(title: 'Trafik ışıkları', videoId: 'fKH0cWm5_ow'),
    Music(title: 'Dişlerimizi nasıl fırçalarız ?', videoId: 'rIoO8TjcNNM'),
    Music(title: 'Arkadaşım Eşşek', videoId: 'q71TncBWoEQ'),
    Music(title: 'Ninni', videoId: '4jP32YgibkM'),
  ];

  Future<void> _downloadVideo(BuildContext context, String videoId) async {
    final appDir = await getApplicationDocumentsDirectory();
    final downloadPath = appDir.path;
    final taskId = await FlutterDownloader.enqueue(
      url: 'https://www.youtube.com/watch?v=$videoId',
      savedDir: downloadPath,
      showNotification: true,
      openFileFromNotification: true,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Video indirme başlatıldı. Görev Kimliği: $taskId'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('Video Listesi'),
      ),
      body: ListView.separated(
        itemCount: musicList.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              musicList[index].title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YouTubePage(
                    videoId: musicList[index].videoId,
                  ),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () {
                _downloadVideo(context, musicList[index].videoId);
              },
            ),
          );
        },
      ),
    );
  }
}

