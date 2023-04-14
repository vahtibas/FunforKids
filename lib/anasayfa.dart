import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funforkids/muzik.dart';
import 'package:funforkids/oyun.dart';
import 'package:funforkids/hayvanlar.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: Text('Anasayfa'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network('data:image/jpeg;base64,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'), // Fotoğrafın URL'si burada belirtilmelidir
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        'Öğretici Bilgi: Ormanlar, dünyadaki en büyük ağaçların ve yaban hayatının yaşadığı yerlerdir. Ormanlar, doğanın büyülü dünyasıdır ve birçok farklı canlının evi olarak bilinir. Ormanları keşfetmek, ağaçları, bitkileri, hayvanları tanımak ve doğayı korumak için önemlidir.',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MusicListPage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue, // Kutu rengi
                          ),
                          child: Icon(Icons.music_note),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KartEslestirmeOyunu()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green, // Kutu rengi
                          ),
                          child: Icon(Icons.gamepad),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HayvanlarSayfasi()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.yellow, // Kutu rengi
                          ),
                          child: Icon(Icons.pets),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
