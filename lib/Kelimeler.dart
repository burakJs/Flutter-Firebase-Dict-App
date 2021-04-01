class Kelimeler {
  String kelimeId;
  String ingilizce;
  String turkce;

  Kelimeler(this.kelimeId, this.ingilizce, this.turkce);

  factory Kelimeler.fromJson(String key, Map<dynamic, dynamic> json) {
    return Kelimeler(key, json["ingilizce"] as String, json["turkce"] as String);
  }
}
