import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

import '../models/location_model.dart';
import '../models/cur_model.dart';
import '../models/today_model.dart';
import '../models/weekly_model.dart';

class FetchData {
  String? apiLocations = 'https://geocoding-api.open-meteo.com/v1/';
  String? endpointSearch = 'search?';
  String? location = '&name=';
  String? count = '&count=5';

  String? apiWeather = 'https://api.open-meteo.com/v1/';
  String? endpointForecast = 'forecast?';
  String? latitude;
  String? longitude;

  String? currentWeather = '&current_weather=true';
  String? todayWeather =
      '&forecast_days=1&hourly=temperature_2m,wind_speed_10m,weather_code';
  String? weeklyWeather =
      '&daily=temperature_2m_max,temperature_2m_min,weather_code';

  String? requestUrl;

  Future<List<Location>> fetchLocations(inputLocation) async {
    if (inputLocation.isEmpty) {
      throw Exception('Input location cannot be empty');
    }
    // debugPrint('inputLocation: $inputLocation');
    try {
      final response = await http.get(
        Uri.parse('$apiLocations$endpointSearch$location$inputLocation$count'),
      );
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final results = (jsonData['results'] ?? []) as List<dynamic>;

        final locations =
            results
                .map((locationJson) => Location.fromJson(locationJson))
                .toList();
        return locations;
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      // throw Exception('Error fetching locations: $e');
      return [
        Location(
          id: 0,
          name: 'Error',
          latitude: 0.0,
          longitude: 0.0,
          country: 'Error',
          admin1: 'Error',
          admin1Id: 0,
          timezone: 'Error',
          elevation: 0,
          population: 0,
          featureCode: 'Error',
          countryCode: 'Error',
          countryId: 0,
        ),
      ];
    }
  }

  Future<CurrentWeather> fetchCurrentWeather() async {
    final response = await http.get(
      Uri.parse(
        '$apiWeather$endpointForecast$latitude$longitude$currentWeather',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final weatherJson = jsonData['current_weather'];
      final weather = CurrentWeather.fromJson(weatherJson);

      return weather;
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<TodayWeather> fetchTodayWeather() async {
    final response = await http.get(
      Uri.parse('$apiWeather$endpointForecast$latitude$longitude$todayWeather'),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final times = jsonData['hourly']['time'] as List<dynamic>;
      final temperatures =
          jsonData['hourly']['temperature_2m'] as List<dynamic>;
      final windSpeeds = jsonData['hourly']['wind_speed_10m'] as List<dynamic>;
      final weatherCodes = jsonData['hourly']['weather_code'] as List<dynamic>;

      final todayWeather = TodayWeather(
        times: times.map((time) => time.toString()).toList(),
        temperatures:
            temperatures.map((temp) => (temp as num).toDouble()).toList(),
        windSpeeds:
            windSpeeds.map((speed) => (speed as num).toDouble()).toList(),
        weatherCodes: weatherCodes.map((code) => code as int).toList(),
      );

      return todayWeather;
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  Future<WeeklyWeather> fetchWeeklyWeather() async {
    final response = await http.get(
      Uri.parse(
        '$apiWeather$endpointForecast$latitude$longitude$weeklyWeather',
      ),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final times = jsonData['daily']['time'] as List<dynamic>;
      final temperaturesMin =
          jsonData['daily']['temperature_2m_min'] as List<dynamic>;
      final temperaturesMax =
          jsonData['daily']['temperature_2m_max'] as List<dynamic>;
      final weatherCodes = jsonData['daily']['weather_code'] as List<dynamic>;

      final weeklyWeather = WeeklyWeather(
        times: times.map((time) => time.toString()).toList(),
        temperaturesMin:
            temperaturesMin.map((temp) => (temp as num).toDouble()).toList(),
        temperaturesMax:
            temperaturesMax.map((temp) => (temp as num).toDouble()).toList(),
        weatherCodes: weatherCodes.map((code) => code as int).toList(),
      );

      return weeklyWeather;
    } else {
      throw Exception('Failed to load forecast');
    }
  }

  void setLongitude(String lon) {
    longitude = 'longitude=$lon&';
  }

  void setLatitude(String lat) {
    latitude = 'latitude=$lat&';
  }
}
