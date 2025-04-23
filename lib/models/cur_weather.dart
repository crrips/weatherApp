class CurrentWeather {
  final double temperature;
  final double windspeed;

  CurrentWeather({required this.temperature, required this.windspeed});

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
      temperature: (json['temperature'] as num).toDouble(),
      windspeed: (json['windspeed'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Temp: $temperature°C\nWind: $windspeed km/h\n';
  }
}
