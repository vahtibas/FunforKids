import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funforkids/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class UyeOlPage extends StatefulWidget {
  const UyeOlPage({Key? key}) : super(key: key);

  @override
  _UyeOlPageState createState() => _UyeOlPageState();
}

class _UyeOlPageState extends State<UyeOlPage> {
  final TextEditingController _ebeveynAdiController = TextEditingController();
  final TextEditingController _ePostaController = TextEditingController();
  final TextEditingController _cocukAdiController = TextEditingController();
  final TextEditingController _sifreController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'uyeler.db';
    String databaseFullPath = path.join(databasePath, databaseName);

    // Veritabanı oluşturma ve açma
    _database = await openDatabase(
      databaseFullPath,
      version: 1,
      onCreate: (db, version) {
        // Tablo oluşturma
        return db.execute('''
          CREATE TABLE IF NOT EXISTS uyeler(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            ebeveynAdi TEXT,
            ePosta TEXT,
            cocukAdi TEXT,
            sifre TEXT
          )
        ''');
      },
    );
  }

  Future<void> _addUser() async {
    await _database.insert(
      'uyeler',
      {
        'ebeveynAdi': _ebeveynAdiController.text,
        'ePosta': _ePostaController.text,
        'cocukAdi': _cocukAdiController.text,
        'sifre': _sifreController.text,
      },
    );

    print("Kullanıcı eklendi");

    // Kayıt eklendikten sonra verileri sıfırla
    _ebeveynAdiController.text = '';
    _ePostaController.text = '';
    _cocukAdiController.text = '';
    _sifreController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('Üye Ol'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _ebeveynAdiController,
                decoration: const InputDecoration(
                  hintText: 'Ebeveyn Adı',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _ePostaController,
                decoration: const InputDecoration(
                  hintText: 'E-posta',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _cocukAdiController,
                decoration: const InputDecoration(
                  hintText: 'Çocuk Adı',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _sifreController,
                decoration: const InputDecoration(
                  hintText: 'Şifre',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _addUser();
                  Navigator.pushNamed(context, '/');
                },
                child: const Text('Kayıt Ol'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
