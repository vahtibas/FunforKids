import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class WordSearchScreen extends StatefulWidget {
  @override
  _WordSearchScreenState createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  final int gridSize = 8;
  List<List<String>> grid = [];
  List<String> words = ['KEDI', 'KOPEK', 'KUS', 'BALIK', 'ASLAN'];
  List<String> foundWords = [];
  List<Offset> selectedCells = [];
  List<List<Offset>> wordLocations = [];
  final player = AudioCache(prefix: 'assets/sounds/');

  @override
  void initState() {
    super.initState();
    _generateGrid();
  }

  void _generateGrid() {
    grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => _getRandomLetter()));
    foundWords.clear();
    wordLocations.clear();
    for (String word in words) {
      _placeWord(word);
    }
  }

  String _getRandomLetter() {
    const letters = 'ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ';
    final random = Random();
    return letters[random.nextInt(letters.length)];
  }

  void _placeWord(String word) {
    final random = Random();
    bool placed = false;

    while (!placed) {
      int row = random.nextInt(gridSize);
      int col = random.nextInt(gridSize);
      int direction = random.nextInt(2); // 0: Horizontal, 1: Vertical

      if (direction == 0 && col + word.length <= gridSize) {
        if (_canPlaceWord(word, row, col, 0, 1)) {
          List<Offset> locations = [];
          for (int i = 0; i < word.length; i++) {
            grid[row][col + i] = word[i];
            locations.add(Offset(row.toDouble(), (col + i).toDouble()));
          }
          wordLocations.add(locations);
          placed = true;
        }
      } else if (direction == 1 && row + word.length <= gridSize) {
        if (_canPlaceWord(word, row, col, 1, 0)) {
          List<Offset> locations = [];
          for (int i = 0; i < word.length; i++) {
            grid[row + i][col] = word[i];
            locations.add(Offset((row + i).toDouble(), col.toDouble()));
          }
          wordLocations.add(locations);
          placed = true;
        }
      }
    }
  }

  bool _canPlaceWord(String word, int row, int col, int rowDir, int colDir) {
    for (int i = 0; i < word.length; i++) {
      int newRow = row + i * rowDir;
      int newCol = col + i * colDir;
      if (grid[newRow][newCol] != _getRandomLetter()) {
        return false;
      }
    }
    return true;
  }

  void _checkSelectedCells() {
    for (int i = 0; i < wordLocations.length; i++) {
      if (_isSelectedCellsMatch(wordLocations[i])) {
        setState(() {
          foundWords.add(words[i]);
          _playSound();
          if (foundWords.length == words.length) {
            _showCompletionDialog();
          }
        });
        return;
      }
    }
  }

  bool _isSelectedCellsMatch(List<Offset> wordLocation) {
    if (wordLocation.length != selectedCells.length) return false;

    for (int i = 0; i < wordLocation.length; i++) {
      if (wordLocation[i] != selectedCells[i]) return false;
    }
    return true;
  }

  void _playSound() async {
    await player.play('match.mp3');
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tebrikler!'),
          content: Text('Tüm kelimeleri buldunuz!'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Yeniden Oyna'),
              onPressed: () {
                setState(() {
                  _generateGrid();
                  foundWords.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: _buildGrid(),
            ),
            _buildWordsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return GestureDetector(
      onPanUpdate: (details) {
        RenderBox renderBox = context.findRenderObject() as RenderBox;
        Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        int row = (localPosition.dy ~/ (renderBox.size.height / gridSize)).clamp(0, gridSize - 1);
        int col = (localPosition.dx ~/ (renderBox.size.width / gridSize)).clamp(0, gridSize - 1);
        Offset cell = Offset(row.toDouble(), col.toDouble());

        if (!selectedCells.contains(cell)) {
          setState(() {
            selectedCells.add(cell);
          });
        }
      },
      onPanEnd: (details) {
        _checkSelectedCells();
        setState(() {
          selectedCells.clear();
        });
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridSize,
        ),
        itemCount: gridSize * gridSize,
        itemBuilder: (context, index) {
          int row = index ~/ gridSize;
          int col = index % gridSize;
          bool isSelected = selectedCells.contains(Offset(row.toDouble(), col.toDouble()));
          bool isFound = wordLocations.any((wordLocation) => wordLocation.contains(Offset(row.toDouble(), col.toDouble())) && foundWords.contains(words[wordLocations.indexOf(wordLocation)]));

          return Container(
            margin: EdgeInsets.all(1.0),
            color: isSelected ? Colors.yellow : isFound ? Colors.green : Colors.purple[100],
            child: Center(
              child: Text(
                grid[row][col],
                style: TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWordsList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Bulunan Kelimeler:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: foundWords
                .map((word) => Chip(
              label: Text(word),
              backgroundColor: Colors.green,
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
