import 'package:flutter/material.dart';
import 'package:weather_flutter/models/weather_model.dart';
import 'package:weather_flutter/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  // api key
  final _weatherService = WeatherService('9faae8eee47107cafc52439a07e0aceb');
  Weather? _weather;

  // fetch weather
  _fetchWeather() async {
    // get current city
    try {
      String cityName = await _weatherService.getCurrentCity();

      // get weather for city
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    }
    // any errors
    catch (e) {
      print('Error fetching weather: $e');
    }
  }

  // weather animations

  // initial state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // city name
            Text(_weather?.cityName ?? "loading city..."),

            // temperature
            Text('{_weather?.temperature.round().toString()}°C'),
          ],
        ),
      ),
    );
  }
}
