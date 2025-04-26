class TodayWeather {
  List<String>? times = [];
  List<double>? temperatures = [];
  List<double>? windSpeeds = [];
  List<int>? weatherCodes = [];

  TodayWeather({
    required this.times,
    required this.temperatures,
    required this.windSpeeds,
    required this.weatherCodes,
  });

  factory TodayWeather.fromJson(Map<String, dynamic> json) {
    final times = json['times'] as List<dynamic>;
    final temperatures = json['temperatures'] as List<dynamic>;
    final windSpeeds = json['wind_speeds'] as List<dynamic>;
    final weatherCodes = json['weather_codes'] as List<dynamic>;

    return TodayWeather(
      times: times.map((time) => time.toString()).toList(),
      temperatures:
          temperatures.map((temp) => (temp as num).toDouble()).toList(),
      windSpeeds: windSpeeds.map((speed) => (speed as num).toDouble()).toList(),
      weatherCodes: weatherCodes.map((code) => code as int).toList(),
    );
  }

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < times!.length; i++) {
      result =
          '$result${times![i].toString().split('T')[1]}\t${temperatures![i]}°C\t${windSpeeds![i]}km/h\n';
    }
    return result;
  }

  List<String> get getTimes {
    return times!;
  }

  List<String> get getHours {
    final List<String> hours = [];
    for (String time in times!) {
      final hour = time.split('T')[1].split(':')[0];
      hours.add(hour);
    }
    return hours;
  }

  List<double> get getTemperatures {
    return temperatures!;
  }

  List<double> get getWindSpeeds {
    return windSpeeds!;
  }

  List<int> get getWeatherCodes {
    return weatherCodes!;
  }
}
