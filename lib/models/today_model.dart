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

    Map<int, String> weatherCodeDescriptions = {
    0: 'Clear sky',
    1: 'Mainly clear',
    2: 'Partly cloudy',
    3: 'Overcast',
    45: 'Fog',
    48: 'Depositing rime fog',
    51: 'Light drizzle',
    53: 'Moderate drizzle',
    55: 'Dense drizzle',
    56: 'Light freezing drizzle',
    57: 'Dense freezing drizzle',
    61: 'Slight rain',
    63: 'Moderate rain',
    65: 'Heavy rain',
    66: 'Light freezing rain',
    67: 'Heavy freezing rain',
    71: 'Slight snowfall',
    73: 'Moderate snowfall',
    75: 'Heavy snowfall',
    77: 'Snow grains',
    80: 'Slight rain showers',
    81: 'Moderate rain showers',
    82: 'Violent rain showers',
    85: 'Slight snow showers',
    86: 'Heavy snow showers',
    95: 'Thunderstorm',
    96: 'Thunderstorm with slight hail',
    99: 'Thunderstorm with heavy hail',
  };
}
