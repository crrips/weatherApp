import '../services/weather_properties.dart';

class CurrentWeather {
  final double temperature;
  final double windspeed;
  final int? weatherCode;

  CurrentWeather({
    required this.temperature,
    required this.windspeed,
    this.weatherCode,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['temperature'] as num).toDouble(),
      windspeed: (json['windspeed'] as num).toDouble(),
      weatherCode: json['weathercode'] as int?,
    );
  }

  @override
  String toString() {
    return 'Temp: $temperature°C\nWind: $windspeed km/h\nWeather: ${weatherCode != null ? WeatherProperties.weatherCodeDescriptions[weatherCode] : 'N/A'}';
  }

  String getTemperature() {
    return '$temperature°C';
  }

  String getWindspeed() {
    return '$windspeed km/h';
  }

  String getWeatherDescription() {
    if (weatherCode != null) {
      return WeatherProperties.weatherCodeDescriptions[weatherCode] ?? 'Unknown weather';
    } else {
      return 'Weather code not available';
    }
  }
}
