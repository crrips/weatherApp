class TodayWeather {
  List<String>? times = [];
  List<double>? temperatures = [];
  List<double>? windSpeeds = [];

  TodayWeather({
    required this.times,
    required this.temperatures,
    required this.windSpeeds,
  });

  factory TodayWeather.fromJson(Map<String, dynamic> json) {
    final times = json['times'] as List<dynamic>;
    final temperatures = json['temperatures'] as List<dynamic>;
    final windSpeeds = json['wind_speeds'] as List<dynamic>;

    return TodayWeather(
      times: times.map((time) => time.toString()).toList(),
      temperatures:
          temperatures.map((temp) => (temp as num).toDouble()).toList(),
      windSpeeds: windSpeeds.map((speed) => (speed as num).toDouble()).toList(),
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
}
