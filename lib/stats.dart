import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  State<Stats> createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  String eAd = 'Ahmet';
  String cAd = 'Ali';
  String ePosta = 'aaa@hotmail.com';
  int sifre = 123456;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text('Kullanıcı Profili'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'E-mail:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              ePosta,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Ebeveyn Adı:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              eAd,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Şifre:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              sifre.toString(),
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            Text(
              'Çocuk Adı:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              cAd,
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
