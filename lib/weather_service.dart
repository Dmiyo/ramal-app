import 'dart:convert'; // Untuk mengubah response JSON ke Map
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'cc4c5ad541b9d52f0592cb1572a555be';
  final String baseUrl = 'https://api.openweathermap.org/data/3.0/onecall';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
  final String url = '$baseUrl?lat=$lat&lon=$lon&exclude=minutely,hourly,daily&appid=$apiKey';
  print('Fetching weather data from: $url'); // Tambahkan log ini untuk memeriksa URL
  
  try {
    final response = await http.get(Uri.parse(url));
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load weather data: ${response.body}');
    }
  } catch (e) {
    print('Error fetching weather data: $e');
    throw Exception('Error fetching weather data: $e');
  }
}

}
