import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:funforkids/games/word_search_screen.dart';
import 'package:funforkids/pages/muzik.dart';
import 'package:funforkids/games/odatopla.dart';
import 'package:funforkids/games/oyun.dart';
import 'package:funforkids/pages/hayvanlar.dart';


class Anasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eğlenceli Çocuk Uygulaması',
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hoş Geldiniz!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: <Color>[Colors.red, Colors.yellow, Colors.green, Colors.blue],
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              buildMenuButton(context, 'Hayvanları Öğren', Icons.pets_rounded, HayvanlarSayfasi(), Colors.greenAccent),
              SizedBox(height: 20),
              buildMenuButton(context, 'Videolar', Icons.ondemand_video_rounded, MuzikSayfasi(), Colors.orangeAccent),
              SizedBox(height: 20),
              buildMenuButton(context, 'Kart Eşleştirme Oyunu', Icons.videogame_asset_rounded, KartEslestirmeOyunu(), Colors.redAccent),
              SizedBox(height: 20),
              buildMenuButton(context, 'Yıldız Toplama Oyunu', Icons.star_border_purple500_sharp, OdaToplaApp(), Colors.blueAccent),
              SizedBox(height: 20),
              buildMenuButton(context, 'Kelime Bulma Oyunu', Icons.search_sharp, WordSearchScreen(), Colors.pinkAccent),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String title, IconData icon, Widget routeWidget, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => routeWidget),
        );
      },
      icon: Icon(icon, size: 40, color: Colors.white),
      label: Text(
        title,
        style: TextStyle(fontSize: 26, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
    );
  }
}
