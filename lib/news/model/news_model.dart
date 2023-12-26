import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class NewsData {
  String? title;
  String? author;
  String? content;
  String? urlToImage;
  String? date;

  NewsData(
    this.title,
    this.author,
    this.content,
    this.date,
    this.urlToImage,
  );

  static List<NewsData> breakingNewsData = [];
  static List<NewsData> recentNewsData = [];

  static List<NewsData> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      return NewsData(
        json['title'],
        json['author'],
        json['content'],
        json['date'],
        json['urlToImage'],
      );
    }).toList();
  }

  static Future<List<NewsData>> fetchNewsDataFromJson() async {
    String url = 'http://filmprojekt1.de/RKEA/News/News.json';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return fromJsonList(jsonData);
    } else {
      throw Exception('Fehler beim Abrufen der Daten');
    }
  }

  static Future<void> updateDataPeriodically() async {
    const Duration updateInterval =
        const Duration(minutes: 30); // Beispiel: alle 30 Minuten aktualisieren

    // Initial einmal Daten abrufen
    await _updateData();

    // Periodischen Timer starten
    Timer.periodic(updateInterval, (Timer timer) async {
      await _updateData();
    });
  }

  static Future<void> _updateData() async {
    List<NewsData> updatedData = await fetchNewsDataFromJson();

    // Hier kannst du Logik hinzufügen, um zu überprüfen, ob sich die Daten geändert haben.
    // Zum Beispiel könntest du prüfen, ob die Länge der neuen Daten unterschiedlich ist oder ob bestimmte Schlüssel unterschiedlich sind.

    // Wenn sich die Daten geändert haben, aktualisiere die Listen
    breakingNewsData = updatedData;
    recentNewsData = updatedData;
  }
}
