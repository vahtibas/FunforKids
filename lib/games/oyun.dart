import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

import 'package:funforkids/pages/anasayfa.dart';

void main() {
  runApp(KartEslestirmeOyunuApp());
}

class KartEslestirmeOyunuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kart Eşleştirme Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: KartEslestirmeOyunu(),
    );
  }
}

class Kart {
  String deger;
  bool acik;
  bool eslesme;

  Kart({required this.deger, this.acik = false, this.eslesme = false});
}

class KartEslestirmeOyunu extends StatefulWidget {
  @override
  _KartEslestirmeOyunuState createState() => _KartEslestirmeOyunuState();
}

class _KartEslestirmeOyunuState extends State<KartEslestirmeOyunu> with SingleTickerProviderStateMixin {
  List<Kart> kartlar = [];
  Kart? seciliKart;
  int eslesmeSayisi = 0;
  List<String> kartDegerleri = ['🐶', '🐱', '🐭', '🐹', '🐰', '🦊'];
  Random random = Random();
  final AudioCache audioCache = AudioCache();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    kartlariOlustur();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void kartlariOlustur() {
    kartlar.clear();
    List<String> kartDegerlerikopya = List.from(kartDegerleri);
    kartDegerlerikopya.shuffle();

    for (int i = 0; i < 6; i++) {
      String deger = kartDegerlerikopya[i];
      kartlar.add(Kart(deger: deger));
      kartlar.add(Kart(deger: deger));
    }
    kartlar.shuffle();
  }

  void playSound(String soundPath) async {
    await audioCache.play(soundPath);
  }

  void kartTiklandi(int index) {
    if (kartlar[index].acik || kartlar[index].eslesme) {
      return;
    }

    setState(() {
      kartlar[index].acik = true;
      if (seciliKart == null) {
        seciliKart = kartlar[index];
      } else {
        if (kartlar[index].deger == seciliKart!.deger) {
          kartlar[index].eslesme = true;
          seciliKart!.eslesme = true;
          eslesmeSayisi++;
          playSound('sounds/match.mp3');
          if (eslesmeSayisi == 6) {
            Future.delayed(Duration(milliseconds: 500), () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text('Tebrikler!', style: TextStyle(color: Colors.pink)),
                  content: Text('Oyunu tamamladınız.', style: TextStyle(color: Colors.pink)),
                  actions: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          kartlariOlustur();
                          eslesmeSayisi = 0;
                          seciliKart = null;
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('Yeniden Oyna'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Anasayfa()),
                        );
                      },
                      child: Text('Anasayfaya Dön'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                    ),
                  ],
                ),
              );
            });
          }
          seciliKart = null;
        } else {
          playSound('sounds/nomatch.mp3');
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              kartlar[index].acik = false;
              seciliKart!.acik = false;
              seciliKart = null;
            });
          });
        }
      }
    });
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
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text('Kart Eşleştirme Oyunu'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemCount: kartlar.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                kartTiklandi(index);
              },
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform(
                    transform: Matrix4.rotationY(kartlar[index].acik ? 0 : pi),
                    alignment: Alignment.center,
                    child: Card(
                      color: kartlar[index].acik ? Colors.white : Colors.purple,
                      child: Center(
                        child: Text(
                          kartlar[index].acik ? kartlar[index].deger : '',
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
