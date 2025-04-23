class WeeklyWeather {
  List<String>? times = [];
  List<double>? temperaturesMin = [];
  List<double>? temperaturesMax = [];
  List<int>? weatherCodes = [];
  WeeklyWeather({
    required this.times,
    required this.temperaturesMin,
    required this.temperaturesMax,
    required this.weatherCodes,
  });

  factory WeeklyWeather.fromJson(Map<String, dynamic> json) {
    final times = json['times'] as List<dynamic>;
    final temperaturesMin = json['temperatures_min'] as List<dynamic>;
    final temperaturesMax = json['temperatures_max'] as List<dynamic>;
    final weatherCodes = json['weather_codes'] as List<dynamic>;

    return WeeklyWeather(
      times: times.map((time) => time.toString()).toList(),
      temperaturesMin:
          temperaturesMin.map((temp) => (temp as num).toDouble()).toList(),
      temperaturesMax:
          temperaturesMax.map((temp) => (temp as num).toDouble()).toList(),
      weatherCodes: weatherCodes.map((code) => code as int).toList(),
    );
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

  String convertDate(String date) {
    Map<int, String> monthNames = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec',
    };

    final DateTime parsedDate = DateTime.parse(date);
    final String formattedDate =
        '${monthNames[parsedDate.month]} ${parsedDate.day}';
    return formattedDate;
  }

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < times!.length; i++) {
      result =
          '$result${convertDate(times![i])}:\nMin: ${temperaturesMin![i]}°C Max: ${temperaturesMax![i]}°C\nWeather: ${weatherCodeDescriptions[weatherCodes![i]]}\n\n';
    }
    return result;
  }
}
