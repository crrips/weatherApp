import '../services/weather_properties.dart';

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

  @override
  String toString() {
    String result = '';
    for (int i = 0; i < times!.length; i++) {
      result =
          '$result${WeatherProperties.convertDate(times![i])}:\nMin: ${temperaturesMin![i]}°C Max: ${temperaturesMax![i]}°C\nWeather: ${WeatherProperties.weatherCodeDescriptions[weatherCodes![i]]}\n\n';
    }
    return result;
  }

  List<double> get getTemperaturesMin {
    return temperaturesMin ?? [];
  }

  List<double> get getTemperaturesMax {
    return temperaturesMax ?? [];
  }

  List<String> get getTimes {
    List<String> formatted = [];
    for (String time in times!) {
      formatted.add(WeatherProperties.convertDate(time));
    }
    return formatted;
  }

  List<int> get getWeatherCodes {
    return weatherCodes ?? [];
  }
}
