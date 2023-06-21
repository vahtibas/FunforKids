import 'package:flutter/material.dart';

class HayvanlarSayfasi extends StatelessWidget {
  final List<Hayvan> hayvanlar = [
    Hayvan("Aslan", "Aslanlar ormanlarda yaşarlar.", "assets/animals/aslan.png"),
    Hayvan("Kedi", "Kediler miyavlar. Evcildirler.", "assets/animals/kedi.png"),
    Hayvan("Köpek", "Köpekler havlarlar. Evcildirler.", "assets/animals/kopek.jpeg"),
    Hayvan("Tavuk", "Tavuklar yumurtlarlar.", "assets/animals/tavuk.jpeg"),
    Hayvan("Fil", "Filler genellikle Afrika ve Asya'da yaşarlar.","assets/animals/fil.png"),
    Hayvan("Kaplumbağa", "Kaplumbağalar karada ve suda yaşarlar.","assets/animals/turtle.png"),
    Hayvan("Koyun", "Koyunlar süt verirler.'meee!'diye ses çıkarırlar.","assets/animals/koyun.png"),
    Hayvan("İnek","İnekler süt verir,'mööö!'sesi çıkarırlar.","assets/animals/inek.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text('Hayvanlar'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              children: hayvanlar.map((hayvan) {
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.asset(
                          hayvan.resimYolu,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          hayvan.ad,
                          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          hayvan.bilgi,
                          style: TextStyle(fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class Hayvan {
  final String ad;
  final String bilgi;
  final String resimYolu;

  Hayvan(this.ad, this.bilgi, this.resimYolu);
}
