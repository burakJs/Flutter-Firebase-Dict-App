import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi_firebase/DetaySayfa.dart';
import 'package:sozluk_uygulamasi_firebase/Kelimeler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  _AnasayfaState createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  var refKelimeler = FirebaseDatabase.instance.reference().child("kelimeler");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu
            ? TextField(
                style: TextStyle(color: Colors.white, fontSize: 24),
                decoration: InputDecoration(
                  hintText: "Arama için bir şey yazın...",
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                ),
                onChanged: (aramaSonucu) {
                  setState(() {
                    aramaKelimesi = aramaSonucu;
                  });
                },
              )
            : Text("Sözlük Uygulamasi"),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                )
        ],
      ),
      body: StreamBuilder<Event>(
        stream: refKelimeler.onValue,
        builder: (context, event) {
          if (event.hasData) {
            var kelimeListesi = <Kelimeler>[];
            var gelenDegerler = event.data.snapshot.value;

            if (gelenDegerler != null) {
              gelenDegerler.forEach((key, nesne) {
                var gelenKelime = Kelimeler.fromJson(key, nesne);
                if (aramaYapiliyorMu) {
                  if (gelenKelime.ingilizce.contains(aramaKelimesi)) {
                    kelimeListesi.add(gelenKelime);
                  }
                } else {
                  kelimeListesi.add(gelenKelime);
                }
              });
            }
            return ListView.builder(
              itemCount: kelimeListesi.length,
              itemBuilder: (context, index) {
                var kelime = kelimeListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetaySayfa(
                          kelime: kelime,
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    height: 100,
                    child: Card(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          kelime.ingilizce,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                        Text(
                          kelime.turkce,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      ],
                    )),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Aradığınız sonuç bulunamadı"),
            );
          }
        },
      ),
    );
  }
}
