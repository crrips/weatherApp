import 'package:flutter/material.dart';

import '../services/fetch_data.dart';
import '../models/cur_weather.dart';
import '../models/today_weather.dart';
import '../models/weekly_weather.dart';

class AppState extends ChangeNotifier {

  CurrentWeather? cur;
  TodayWeather? today;
  WeeklyWeather? weekly;

  bool isGeoPressed = false;
  bool isGeolocationEnabled = false;

  String? lat;
  String? lon;

  String? curWeatherText;
  String? todayWeatherText;
  String? weeklyWeatherText;

  String? apiFail;

  final fetchData = FetchData();

  Future<void> updateWeather() async {
    fetchData.setLatitude(lat!);
    fetchData.setLongitude(lon!);

    try {
      cur = await fetchData.fetchCurrentWeather();
      today = await fetchData.fetchTodayWeather();
      weekly = await fetchData.fetchWeeklyWeather();

      setCurWeatherText(cur.toString());
      setTodayWeatherText(today.toString());
      setWeeklyWeatherText(weekly.toString());
    } catch (e) {
      apiFail = 'API call failed';
      debugPrint('Error fetching weather: $e');
      notifyListeners();
    }
  }

  void enableSearch(String latitude, String longitude) {
    isGeolocationEnabled = false;
    isGeoPressed = false;
    lat = latitude;
    lon = longitude;
    notifyListeners();
  }

  void enableGeo(String latitude, String longitude) {
    isGeoPressed = true;
    isGeolocationEnabled = true;
    lat = latitude;
    lon = longitude;
    notifyListeners();
  }

  void disableGeo() {
    isGeoPressed = false;
    lat = null;
    lon = null;
    notifyListeners();
  }

  void toggleGeoPressed() {
    isGeoPressed = !isGeoPressed;
    notifyListeners();
  }

  void setGeolocationEnabled(bool value) {
    isGeolocationEnabled = value;
    notifyListeners();
  }

  void setCurWeatherText(String text) {
    curWeatherText = text;
    notifyListeners();
  }

  void setTodayWeatherText(String text) {
    todayWeatherText = text;
    notifyListeners();
  }

  void setWeeklyWeatherText(String text) {
    weeklyWeatherText = text;
    notifyListeners();
  }

  void clearWeather() {
    lat = null;
    lon = null;
    curWeatherText = null;
    todayWeatherText = null;
    weeklyWeatherText = null;
    isGeoPressed = false;
    isGeolocationEnabled = false;
    notifyListeners();
  }
}
