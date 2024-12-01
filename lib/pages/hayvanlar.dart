import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // dart:io paketini ekleyin

class Hayvan {
  final String name;
  final String description;
  final String image;
  final String sound;

  Hayvan(this.name, this.description, this.image, this.sound);
}

class HayvanlarSayfasi extends StatelessWidget {
  final List<Hayvan> animals = [
    Hayvan("Aslan", "Aslanlar ormanların kralıdır! Büyük ve gür yeleleri olan erkek aslanlar, kükremeleriyle ünlüdür. Genellikle sürü halinde yaşarlar ve dişi aslanlar avlanma konusunda ustadır. Aslanlar kükrediğinde sesi kilometrelerce öteden duyulabilir. Ne kadar güçlü değil mi?", "assets/animals/aslan.png", "assets/sounds/aslan.mp3"),
    Hayvan("Kedi", "Kediler miyavlar ve patileriyle oynar! Evcildirler ve insanlarla yaşamayı severler. Kediler, sessizce hareket ederek avlarını yakalar. Kedi dostlarımızın en sevdikleri şeylerden biri de oyun oynamaktır. Peki senin kedin neyle oynamayı sever?", "assets/animals/kedi.png", "assets/sounds/kedi.mp3"),
    Hayvan("Köpek", "Köpekler sadık dostlarımızdır! Havlayarak bize haber verirler ve oyun oynamayı çok severler. Birçok farklı türde köpek vardır; bazıları büyük ve güçlü, bazıları ise küçük ve sevimlidir. Köpekler, insanlarla çok iyi anlaşır ve onlara yardımcı olmayı severler.", "assets/animals/kopek.jpeg", "assets/sounds/kopek.mp3"),
    Hayvan("Tavuk", "Tavuklar yumurtlar ve sabahları 'gıdak gıdak' diye ses çıkarır! Çiftliklerde yaşarlar ve taze yumurtalar sağlarlar. Tavukların renkli tüyleri ve komik yürüyüşleri vardır. Horozlar ise sabahları ötüşleriyle güne başlar.", "assets/animals/tavuk.jpeg", "assets/sounds/tavuk.mp3"),
    Hayvan("Fil", "Filler büyük ve nazik devlerdir! Uzun hortumlarıyla su içebilir ve yiyecek toplayabilirler. Filler, kalın derileri ve büyük kulaklarıyla tanınır. Aileleriyle birlikte yaşar ve uzun yıllar boyunca birlikte kalırlar. Filler suyu çok sever ve su birikintilerinde oynamaktan hoşlanırlar.", "assets/animals/fil.png", "assets/sounds/fil.mp3"),
    Hayvan("Kaplumbağa", "Kaplumbağalar yavaş ve sabırlıdır! Sert kabukları onları korur. Hem karada hem de suda yaşayabilirler. Kaplumbağalar uzun ömürlüdür; bazıları 100 yıldan fazla yaşayabilir! Küçük adımlarla ilerlerken etrafı keşfetmekten hoşlanırlar.", "assets/animals/turtle.png", "assets/sounds/turtle.mp3"),
    Hayvan("Koyun", "Koyunlar yumuşacık yünleriyle tanınır! 'Meee!' diye ses çıkarırlar ve sürüler halinde yaşarlar. Koyunlar çimen yer ve genellikle çiftliklerde bulunurlar. Koyunların tüyleri kesilerek yün yapılır, bu yünle kazaklar ve battaniyeler yapılır.", "assets/animals/koyun.png", "assets/sounds/koyun.mp3"),
    Hayvan("İnek", "İnekler 'mööö' der ve süt verir! Büyük otlaklarda yaşarlar ve ot yerler. İneklerin sütüyle peynir, yoğurt ve dondurma yapılır. İnekler sakin ve dost canlısı hayvanlardır. Çiftliklerde ve otlaklarda rahatça gezip dolaşırlar.", "assets/animals/inek.png", "assets/sounds/inek.mp3"),
    Hayvan("Yunus", "Yunuslar denizin en neşeli hayvanlarıdır! Zıplamayı ve suyun üzerinde akrobatik hareketler yapmayı çok severler. Yunuslar çok zeki hayvanlardır ve birbirleriyle iletişim kurmak için ıslık çalar gibi sesler çıkarırlar. Ayrıca insanlarla da iyi anlaşırlar ve bazen insanların yanında yüzmeyi severler. Ne kadar eğlenceli değil mi?", "assets/animals/yunus.png", "assets/sounds/yunus.mp3"),
    Hayvan("Penguen", "Penguenler, kutupların sevimli ve komik yürüyüşlü sakinleridir! Siyah beyaz tüyleri vardır ve buzlu bölgelerde yaşarlar. Penguenler çok iyi yüzücüdür ve su altında hızlıca hareket edebilirler. Yavru penguenler, anne ve babalarının sıcak tüyleri arasında saklanarak büyürler. Penguenler birbirlerine çok bağlıdır ve büyük gruplar halinde yaşarlar.", "assets/animals/penguen.png", "assets/sounds/penguen.mp3"),
    Hayvan("Zürafa", "Zürafalar dünyanın en uzun hayvanlarıdır! Uzun boyunları sayesinde ağaçların yapraklarını kolayca ulaşabilirler. Afrika savanalarında yaşarlar ve uzun bacaklarıyla hızlıca koşabilirler. Zürafalar, uzun kirpikleri ve benekli desenleriyle çok güzeldir. Zürafaların dilleri de çok uzundur ve yaprakları yakalamak için kullanırlar.", "assets/animals/zurafa.png", "assets/sounds/zurafa.mp3"),
  ];

  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hayvanlar Dünyası',
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
          padding: EdgeInsets.all(16),
          itemCount: animals.length,
          itemBuilder: (context, index) {
            final animal = animals[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10),
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    child: Image.asset(
                      animal.image,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.contain, // Resimlerin kırpılmadan tamamını gösterir
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          animal.name,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          animal.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            // Ses dosyasını bellekten yükleyip oynatıyoruz
                            final ByteData data = await rootBundle.load(animal.sound);
                            final List<int> bytes = data.buffer.asUint8List();
                            final Directory tempDir = await getTemporaryDirectory();
                            final File tempFile = File('${tempDir.path}/${animal.sound.split('/').last}');
                            await tempFile.writeAsBytes(bytes, flush: true);
                            await _audioPlayer.play(tempFile.path, isLocal: true);
                          },
                          child: Text('Sesini Dinle'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
