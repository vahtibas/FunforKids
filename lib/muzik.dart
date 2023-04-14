import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Music {
  String title;
  bool isPlaying;

  Music({required this.title, this.isPlaying = false});
}

class MusicListPage extends StatefulWidget {
  @override
  _MusicListPageState createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  List<Music> musicList = [
    Music(title: 'Müzik 1'),
    Music(title: 'Müzik 2'),
    Music(title: 'Müzik 3'),
    Music(title: 'Müzik 4'),
    Music(title: 'Müzik 5'),
  ];

  void _playMusic(Music music) {

    setState(() {
      music.isPlaying = true;
    });
    print('Müzik çalınıyor: ${music.title}');
  }

  void _pauseMusic(Music music) {

    setState(() {
      music.isPlaying = false;
    });
    print('Müzik durdu: ${music.title}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text('Müzik Listesi'),
      ),
      body: ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(musicList[index].title),
            trailing: IconButton(
              icon: Icon(
                musicList[index].isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ), // İkonu güncelle
              onPressed: () {
                if (musicList[index].isPlaying) {
                  _pauseMusic(musicList[index]);
                } else {
                  _playMusic(musicList[index]);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Kütüphane ekleme işlemi gerçekleştirildi');
        },
        child: Icon(Icons.library_add),
      ),
    );
  }
}

