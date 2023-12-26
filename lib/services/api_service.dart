import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
// Import the abstract class

abstract class ApiService {
  Future<Map<String, String>> fetchMediaInfo();
}

class TestApiService implements ApiService {
  @override
  Future<Map<String, String>> fetchMediaInfo() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double latitude = position.latitude;
      double longitude = position.longitude;
      const apiUrl = "http://filmprojekt1.de:3000/api/v1/audio";
      final url =
          Uri.parse('$apiUrl?userLatitude=$latitude&userLongitude=$longitude');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> rawData = json.decode(response.body);

        // Assuming 'audioFiles' is a key in the response map
        final List<dynamic> audioFiles = rawData['audioFiles'];

        if (audioFiles != null && audioFiles.isNotEmpty) {
          // Assuming you want information about the first audio file
          final Map<String, dynamic> firstAudioFile = audioFiles.first;

          final String id = firstAudioFile['id'].toString();
          final String album = firstAudioFile['album'];
          final String title = firstAudioFile['title'];
          final String url = firstAudioFile['url'];

          // Modify this part to extract other fields as needed

          final Map<String, String> data = {
            'id': id,
            'album': album,
            'title': title,
            'url': url
          };
          return data;
        } else {
          print('Fehler bei der API-Anfrage: No audio files found');
          return {};
        }
      } else {
        print('Fehler bei der API-Anfrage: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      print('Fehler bei der API-Anfrage: $e');
      return {};
    }
  }
}


// ... (rest of your code)
