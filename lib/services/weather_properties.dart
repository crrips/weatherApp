import 'package:flutter/material.dart';

class WeatherProperties {
  static Map<int, String> weatherCodeDescriptions = {
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

  static IconData getWeatherIcon(weatherCode) {
    if (weatherCode == 0) return Icons.wb_sunny;
    if ([1, 2].contains(weatherCode)) {
      return Icons.wb_sunny_outlined;
    }
    if (weatherCode == 3) return Icons.cloud;
    if ([45, 48].contains(weatherCode)) return Icons.foggy;
    if ([51, 53, 55, 56, 57].contains(weatherCode)) {
      return Icons.grain;
    }
    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(weatherCode)) {
      return Icons.umbrella;
    }
    if ([71, 73, 75, 77, 85, 86].contains(weatherCode)) return Icons.ac_unit;
    if ([95, 96, 99].contains(weatherCode)) return Icons.thunderstorm;
    return Icons.help_outline;
  }

  static Color getWeatherIconColor(weatherCode) {
    if ([0, 1, 2].contains(weatherCode)) {
      return Colors.amber;
    }
    if (weatherCode == 3) {
      return Colors.grey;
    }
    if ([45, 48].contains(weatherCode)) {
      return Colors.blueGrey;
    }
    if ([51, 53, 55, 56, 57].contains(weatherCode)) {
      return Colors.lightBlueAccent;
    }
    if ([61, 63, 65, 66, 67, 80, 81, 82].contains(weatherCode)) {
      return Colors.blue;
    }
    if ([71, 73, 75, 77, 85, 86].contains(weatherCode)) {
      return Colors.white;
    }
    if ([95, 96, 99].contains(weatherCode)) {
      return Colors.blue[800]!;
    }
    return Colors.white70;
  }

  static String convertDate(String date) {
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
}
