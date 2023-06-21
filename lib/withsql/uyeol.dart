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
  void dispose() {
    _ebeveynAdiController.dispose();
    _ePostaController.dispose();
    _cocukAdiController.dispose();
    _sifreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text("Üye Ol"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 24.0),
              TextFormField(
                controller: _ebeveynAdiController,
                onChanged: (text) {},
                decoration: const InputDecoration(
                  labelText: 'Ebeveyn Adı',
                  hintText: 'Ebeveyn Adı Gir',
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _ePostaController,
                decoration: const InputDecoration(
                  labelText: 'E-Posta',
                  hintText: 'E-Posta Gir',
                ),
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _cocukAdiController,
                decoration: const InputDecoration(
                  labelText: 'Çocuk Adı',
                  hintText: 'Çocuk Adı Gir',
                ),
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.singleLineFormatter,
                ],
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _sifreController,
                decoration: const InputDecoration(
                  labelText: 'Şifre',
                  hintText: 'Şifre Gir',
                ),
                keyboardType: TextInputType.visiblePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                obscureText: true,
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  _addUser().then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Stats(database: _database)),
                    );
                  });
                },
                child: const Text("ÜYE OL"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: "anasayfa")),
                  );
                },
                child: const Text("Ana Sayfaya Dön"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Stats extends StatefulWidget {
  final Database database;

  const Stats({Key? key, required this.database}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String eAd = '';
  String cAd = '';
  String ePosta = '';
  String sifre = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    List<Map<String, dynamic>> result = await widget.database.query('uyeler');
    if (result.isNotEmpty) {
      setState(() {
        eAd = result[0]['ebeveynAdi'];
        cAd = result[0]['cocukAdi'];
        ePosta = result[0]['ePosta'];
        sifre = result[0]['sifre'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: const Text('Kullanıcı Profili'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'E-mail:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              ePosta,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            const Text(
              'Ebeveyn Adı:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              eAd,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            const Text(
              'Çocuk Adı:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              cAd,
              style: const TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            const Text(
              'Şifre:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              sifre,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
