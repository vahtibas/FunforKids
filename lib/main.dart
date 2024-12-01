import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funforkids/pages/anasayfa.dart';
import 'package:funforkids/pages/muzik.dart';
import 'package:funforkids/games/odatopla.dart';
import 'package:funforkids/games/oyun.dart';
import 'package:funforkids/pages/hayvanlar.dart';
import 'package:funforkids/withsql/kimkullaniyor.dart';
import 'package:funforkids/withsql/uyeol.dart';
//import 'package:funforkids/database/database_helper.dart'; // Yorum satırına alındı

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: "Ana Sayfa"),
        '/anasayfa': (context) => Anasayfa(),
        '/hayvanlar': (context) => HayvanlarSayfasi(),
        '/muzik': (context) => MuzikSayfasi(),
        '/oyun': (context) => KartEslestirmeOyunu(),
        '/yaris': (context) => OdaToplaApp(),
        '/kimkullaniyor': (context) => KimKullaniyor(),
        '/uyeol': (context) => const UyeOlPage(),
      },
    ),
  );
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  //DatabaseHelper _databaseHelper = DatabaseHelper(); // Yorum satırına alındı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'FUN for KIDS',
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'E-mailinizi girin',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Şifrenizi girin',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                  obscureText: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Giriş kontrolü kodları devre dışı bırakıldı
                  // String email = _emailController.text;
                  // String password = _passwordController.text;
                  // bool isLoggedIn = await _databaseHelper.login(email, password);
                  // if (isLoggedIn) {
                  Navigator.pushNamed(context, '/anasayfa');
                  // } else {
                  //   showDialog(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: const Text('Hatalı Bilgiler'),
                  //         content: const Text('Girdiğiniz e-posta veya şifre hatalı.'),
                  //         actions: [
                  //           ElevatedButton(
                  //             onPressed: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //             child: const Text('Tamam'),
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                },
                child: const Text("Giriş yap"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/uyeol');
                },
                child: const Text("Üye olmak için tıklayın"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white, textStyle: TextStyle(fontSize: 18, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
