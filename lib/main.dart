import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funforkids/kimkullaniyor.dart';
import 'package:funforkids/uyeol.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Uyeol(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String eAd = 'Ahmet';
  String cAd = 'ali';
  String ePosta = 'aaa@hotmail.com';
  int sifre = 123456;

  void eIsimKaydet(String text) {
    setState(() {
      eAd = text;
    });
  }

  void cIsimKaydet(String text) {
    setState(() {
      cAd = text;
    });
  }

  void epostaKaydet(String text) {
    setState(() {
      ePosta = text;
    });
  }

  void sifreKaydet(int value) {
    setState(() {
      sifre = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FUN for KIDS',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink,
          title: Text("Hoşgeldiniz"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'E-mailinizi girin',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  inputFormatters: [
                    FilteringTextInputFormatter.singleLineFormatter
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Şifrenizi girin',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => KimKullaniyor()),
                    );
                  },
                  child: Text("Giriş yap"),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Uyeol()),
                  );
                },
                child: Text("Üye ol"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
