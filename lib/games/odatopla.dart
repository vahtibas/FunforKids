import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'dart:async';

import 'package:funforkids/pages/anasayfa.dart'; // Anasayfa import


class OdaToplaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oda Topla Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: OdaToplaScreen(),
    );
  }
}

class OdaToplaScreen extends StatefulWidget {
  @override
  _OdaToplaScreenState createState() => _OdaToplaScreenState();
}

class _OdaToplaScreenState extends State<OdaToplaScreen> with SingleTickerProviderStateMixin {
  List<Offset> itemPositions = [];
  Random random = Random();
  int score = 0;
  late AnimationController _controller;
  final AudioCache audioCache = AudioCache();
  late Animation<Offset> _animation;
  int _start = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(0, 0.1),
    ).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      generateItems();
    });
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _start = 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          showGameOverDialog();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Oyun Bitti!'),
        content: Text('Süreniz doldu. Puanınız: $score'),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OdaToplaApp()),
              );
            },
            child: Text('Yeniden Oyna'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Anasayfa()), // Anasayfa yönlendirme
              );
            },
            child: Text('Anasayfaya Dön'),
          ),
        ],
      ),
    );
  }

  void generateItems() {
    itemPositions.clear();
    final size = MediaQuery.of(context).size;
    for (int i = 0; i < 10; i++) {
      itemPositions.add(Offset(random.nextDouble() * (size.width - 50), random.nextDouble() * (size.height - 150)));
    }
    setState(() {});
  }

  void playSound(String soundPath) async {
    await audioCache.play(soundPath);
  }

  void onItemTapped(int index) {
    setState(() {
      score += 10;
      playSound('sounds/match.mp3');
      itemPositions.removeAt(index);
      if (itemPositions.isEmpty) {
        showGameOverDialog();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Yıldız Topla Oyunu'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.orangeAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            ...List.generate(itemPositions.length, (index) {
              return Positioned(
                left: itemPositions[index].dx,
                top: itemPositions[index].dy,
                child: GestureDetector(
                  onTap: () => onItemTapped(index),
                  child: SlideTransition(
                    position: _animation,
                    child: Icon(Icons.star, size: 70, color: Colors.yellow),
                  ),
                ),
              );
            }),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text('Puan: $score', style: TextStyle(fontSize: 24, color: Colors.white)),
                    SizedBox(height: 10),
                    Text('Süre: $_start', style: TextStyle(fontSize: 24, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
