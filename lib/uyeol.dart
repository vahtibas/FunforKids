import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text("Üye Ol"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 24.0),
              TextFormField(
                controller: _ebeveynAdiController,
                onChanged: (text) {
                  // EisimKaydet(text);
                },
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                decoration: InputDecoration(
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
                },
                child: Text("ÜYE OL"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage(title: "Ana Sayfa")),
                  );
                },
                child: Text("Ana Sayfaya Dön"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
