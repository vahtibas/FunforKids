import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(KartEslestirmeOyunuApp());
}

class KartEslestirmeOyunuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kart Eşleştirme Oyunu',
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

class _KartEslestirmeOyunuState extends State<KartEslestirmeOyunu> {
  List<Kart> kartlar = [];
  Kart? seciliKart;
  int eslesmeSayisi = 0;
  List<String> kartDegerleri = ['A', 'B', 'C', 'D', 'E', 'F'];
  Random random = Random();

  void kartlariOlustur() {
    kartlar.clear();
    List<String> kartDegerlerikopya =
        List.from(kartDegerleri);
    kartDegerlerikopya.shuffle();

    for (int i = 0; i < 6; i++) {
      String deger = kartDegerlerikopya[i];
      kartlar.add(Kart(deger: deger));
      kartlar.add(Kart(deger: deger));
    }
    kartlar.shuffle();
  }

  void kartTiklandi(int index) {
    setState(() {
      if (!kartlar[index].acik && seciliKart == null) {
        kartlar[index].acik = true;
        seciliKart = kartlar[index];
      } else if (!kartlar[index].acik && seciliKart != null) {
        kartlar[index].acik = true;
        if (kartlar[index].deger == seciliKart!.deger) {
          kartlar[index].eslesme = true;
          seciliKart!.eslesme = true;

          kartlar[index].acik = true;
          seciliKart!.acik = true;
          seciliKart = null;

          eslesmeSayisi++;
          if (eslesmeSayisi == 6) {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Tebrikler!'),
                      content: Text('Oyunu tamamladınız.'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {

                            setState(() {
                              kartlariOlustur();
                              eslesmeSayisi = 0;
                              Navigator.of(context).pop();
                            }
                            );
                          },
                          child: Text('Yeniden Oyna'),
                        )
                      ],
                    ));
          }
        } else {
          Future.delayed(Duration(milliseconds: 500), () {
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
  void initState() {
    super.initState();
    kartlariOlustur();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text('Kart Eşleştirme Oyunu'),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: kartlar.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              kartTiklandi(index);
            },
            child: Card(
              color: kartlar[index].acik ? Colors.white : Colors.blue,
              child: Center(
                child: Text(
                  kartlar[index].acik ? kartlar[index].deger : '',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
