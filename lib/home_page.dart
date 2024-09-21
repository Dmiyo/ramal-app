import 'package:flutter/material.dart';
import 'weather_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    try {
      // Gantilah latitude dan longitude sesuai lokasi Anda
      double latitude = -6.200000;  // Contoh latitude untuk Jakarta
      double longitude = 106.816666; // Contoh longitude untuk Jakarta
      
      Map<String, dynamic> data = await _weatherService.fetchWeather(latitude, longitude);
      
      setState(() {
        _weatherData = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: const Text(
            'RAMAL',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Color.fromRGBO(99, 211, 246, 1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (_weatherData != null) ...[
                          Image.asset(
                            'assets/Awal 1 2.png',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_weatherData!['current']['temp']}°', // Menampilkan suhu dari API
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            '20, July 2024\nDepok, Jawa Barat',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              WeatherCard(
                                temperature: '30°',
                                time: '12.00',
                                icon: Icons.wb_sunny,
                              ),
                              WeatherCard(
                                temperature: '27°',
                                time: '13.00',
                                icon: Icons.cloud,
                              ),
                              WeatherCard(
                                temperature: '26°',
                                time: '14.00',
                                icon: Icons.grain,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final String temperature;
  final String time;
  final IconData icon;

  const WeatherCard({
    Key? key,
    required this.temperature,
    required this.time,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 8),
            Text(
              temperature,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
