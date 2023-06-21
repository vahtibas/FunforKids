import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:funforkids/withsql/kimkullaniyor.dart';
import 'package:funforkids/withsql/uyeol.dart';
import 'package:funforkids/database/database_helper.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: "Ana Sayfa"),
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
  DatabaseHelper _databaseHelper = DatabaseHelper();

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
                  controller: _emailController,
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
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Şifrenizi girin',
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  obscureText: true, // Şifreyi nokta şeklinde görüntüler
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () async {
                    String enteredEmail = _emailController.text;
                    String enteredPassword = _passwordController.text;

                    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KimKullaniyor(),
                        ),
                      );
                    } else {
                      var userData = await _databaseHelper.getUserData();
                      if (userData.isNotEmpty) {
                        String storedEmail = userData['email'];
                        String storedPassword = userData['password'];

                        if (enteredEmail == storedEmail &&
                            enteredPassword == storedPassword) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => KimKullaniyor(),
                            ),
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hatalı Bilgiler'),
                                content: const Text(
                                    'Girdiğiniz e-posta veya şifre hatalı.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tamam'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Hatalı Bilgiler'),
                              content: const Text(
                                  'Girdiğiniz e-posta veya şifre hatalı.'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Tamam'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                  child: const Text("Giriş yap"),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UyeOlPage()),
                  );
                },
                child: const Text("Üye olmak için tıklayın"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
