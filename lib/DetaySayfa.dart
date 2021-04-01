import 'package:flutter/material.dart';
import 'package:sozluk_uygulamasi_firebase/Kelimeler.dart';

// ignore: must_be_immutable
class DetaySayfa extends StatefulWidget {
  Kelimeler kelime;
  DetaySayfa({this.kelime});

  @override
  _DetaySayfaState createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay Sayfa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              widget.kelime.ingilizce,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 64,
                color: Colors.pink,
              ),
            ),
            Text(
              widget.kelime.turkce,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 64,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
