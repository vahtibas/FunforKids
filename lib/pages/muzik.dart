import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MuzikSayfasi extends StatefulWidget {
  @override
  _MuzikSayfasiState createState() => _MuzikSayfasiState();
}

class _MuzikSayfasiState extends State<MuzikSayfasi> {
  List<Map<String, String>> videos = [
    {
      'id': 'bkB6WyuDlfM',
      'title': 'Rafadan Tayfa | Uykusuzluk',
      'description': 'Mert ve Akın bir bisiklete binmiş, heyecanla sürerken bisiklet bozulur. Sadettin Usta’ya götürmeye karar verirler. Dükkana vardıklarında Sadettin Usta’yı keyifsiz ve bitkin görürler. Sadettin Usta kaç zamandır uyuyamadığını ve işler biriktiği için bisikleti hemen tamir edemeyeceğini söyler. Çocuklar Usta’ya uyumasına yardım edecek birkaç öneride bulunur..'
    },
    {
      'id': 'ppaYj3uo_a4',
      'title': 'Niloya - Kar, Sarı yapraklar, İlkbahar, Buz',
      'description': 'Niloya birleştirilmiş bölümler.'
    },
    {
      'id': 'hhrJVzdbSzw',
      'title': 'Keloğlan - Altın Balık',
      'description': 'Keloğlan, annesinin izni olmadan balık tutma yarışına katılır. Yanında gizlice babasının oltasını da götürür.'
    },
    {
      'id': 'tqhtMUJ_u3w',
      'title': 'Kaf Dağı Masalları - Kayıp Tarak',
      'description': 'Hayvancılıkla uğraşan bir Devin , Devler Ülkesi Padişahının kızını kurtarışını konu alan bir masal.'
    },
    {
      'id': 'FjEivL3D3HM',
      'title': 'Bizim Ninniler - Çamlıbelden Çıktım Yayan',
      'description': 'Ninnileri farklı çizgileriyle şölene dönüştüren “Bizim Ninniler” çocukların uykularına ve rüyalarına eşlik ediyor. tüm çocuklara uyusun da büyüsün, fış fış kayıkçı, eşekli ninni, dandini dandini dastana, atem tutem men seni, danalı bebek’li rüyalar!'
    },
    {
      'id': 'eWJW-QrBVHc',
      'title': 'Kız Kulesi Masalları | Bakla Ağacı | Pelin Çift',
      'description': 'İyi akşamlar. Ben Pelin. Çocuklar, güneşin içimizi ısıttığı günleri sever misiniz? Peki ya kartopu oynamayı? Birini seçin desem yazı mı seçersiniz, kışı mı? Bakın masaldaki ninemiz hangisini seçmiş, sonra neler olmuş…'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Videolar',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            Map<String, String> video = videos[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoPlayerScreen(videoId: video['id']!),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Image.network(
                        YoutubePlayer.getThumbnail(
                          videoId: video['id']!,
                          quality: ThumbnailQuality.high,
                        ),
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video['title']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            video['description']!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String videoId;

  VideoPlayerScreen({required this.videoId});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video İzle'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.amber,
                onReady: () {
                  _controller.addListener(() {});
                },
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        _controller.pause();
                      },
                      icon: Icon(Icons.pause, color: Colors.white),
                      label: Text('Duraklat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _controller.play();
                      },
                      icon: Icon(Icons.play_arrow, color: Colors.white),
                      label: Text('Oynat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        _controller.seekTo(Duration(seconds: 0));
                      },
                      icon: Icon(Icons.replay, color: Colors.white),
                      label: Text('Başa Sar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
