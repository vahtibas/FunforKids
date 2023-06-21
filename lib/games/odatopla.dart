import 'dart:math';
import 'package:flutter/material.dart';
import 'package:funforkids/pages/anasayfa.dart';

class RoomCleanupGame extends StatelessWidget {
  const RoomCleanupGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RoomPage(),
    );
  }
}

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  _RoomPageState createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<String> items = [
    'pencil',
    'book',
    'notebook',
    'toy',
    'pillow',
    'eraser',
    'crayon',
    'ruler',
    'paper',
    'scissors'
  ];
  List<String> collectedItems = [];
  bool gameEnded = false;
  List<Offset> itemPositions = [];

  @override
  void initState() {
    super.initState();
    restartGame();
  }

  void restartGame() {
    setState(() {
      collectedItems.clear();
      items = [
        'pencil',
        'book',
        'notebook',
        'toy',
        'pillow',
        'eraser',
        'crayon',
        'ruler',
        'paper',
        'scissors'
      ];
      shuffleItems();
      gameEnded = false;
      itemPositions.clear();
      for (int i = 0; i < items.length && i < 8; i++) {
        itemPositions.add(generateRandomPosition());
      }
    });
  }

  void shuffleItems() {
    final random = Random();
    items.shuffle(random);
  }

  Offset generateRandomPosition() {
    final random = Random();
    final x = random.nextDouble() * (300 - 80);
    final y = random.nextDouble() * (400 - 80);
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('Çocuk Odası Temizleme Oyunu'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Anasayfa()),
            );

          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/room_wallpaper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (!gameEnded)
            for (int i = 0; i < items.length && i < 8; i++)
              Positioned(
                top: itemPositions[i].dy,
                left: itemPositions[i].dx,
                child: Draggable<String>(
                  data: items[i],
                  feedback: Image.asset(
                    'assets/stuff/${items[i]}.png',
                    width: 80,
                    height: 80,
                  ),
                  childWhenDragging: Container(),
                  child: Image.asset(
                    'assets/stuff/${items[i]}.png',
                    width: 80,
                    height: 80,
                  ),
                ),
              ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DragTarget<String>(
              onAccept: (item) {
                setState(() {
                  collectedItems.add(item);
                  items.remove(item);
                });
                if (items.isEmpty) {
                  setState(() {
                    gameEnded = true;
                  });
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Tebrikler!'),
                      content: const Text('Oyunu tamamladınız. Bütün eşyaları topladınız.'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                           restartGame();
                              Navigator.of(AlertDialog() as BuildContext).pop();
                          },
                          child: const Text('Yeniden Oyna'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Anasayfa()),
                            );

                          },
                          child: const Text('Ana Sayfa'),
                        ),
                      ],
                    ),
                  );
                }
              },
              builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.arrow_downward),
                      SizedBox(width: 8),
                      Text(
                        'Eşyalarınızı dolaba koyun',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
