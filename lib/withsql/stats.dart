import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funforkids/main.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class Uyeol extends StatefulWidget {
  const Uyeol({Key? key}) : super(key: key);

  @override
  _UyeolState createState() => _UyeolState();
}

class _UyeolState extends State<Uyeol> {
  TextEditingController _ebeveynAdiController = TextEditingController();
  TextEditingController _ePostaController = TextEditingController();
  TextEditingController _cocukAdiController = TextEditingController();
  TextEditingController _sifreController = TextEditingController();

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

  Future<void> addUser() async {
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
                  addUser().then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Stats()),
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
                    MaterialPageRoute(builder: (context) => const MyHomePage(title: "anasayfa",)),
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
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String eAd = '';
  String cAd = '';
  String ePosta = '';
  int sifre = 0;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'uyeler.db';
    String databaseFullPath = path.join(databasePath, databaseName);

    Database database = await openDatabase(
      databaseFullPath,
      version: 1,
    );

    List<Map<String, dynamic>> result = await database.query('uyeler');
    if (result.isNotEmpty) {
      setState(() {
        eAd = result[0]['ebeveynAdi'];
        cAd = result[0]['cocukAdi'];
        ePosta = result[0]['ePosta'];
        sifre = int.parse(result[0]['sifre']);
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
              'Şifre:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              sifre.toString(),
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
          ],
        ),
      ),
    );
  }
}
