class Location {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final int elevation;
  final String featureCode;
  final String countryCode;
  final int admin1Id;
  final String timezone;
  final int population;
  final int countryId;
  final String country;
  final String admin1;

  Location({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.elevation,
    required this.featureCode,
    required this.countryCode,
    required this.admin1Id,
    required this.timezone,
    required this.population,
    required this.countryId,
    required this.country,
    required this.admin1,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      elevation: json['elevation'] ?? 0,
      featureCode: json['feature_code'] ?? '',
      countryCode: json['country_code'] ?? '',
      admin1Id: json['admin1_id'] ?? 0,
      timezone: json['timezone'] ?? '',
      population: json['population'] ?? 0,
      countryId: json['country_id'] ?? 0,
      country: json['country'] ?? '',
      admin1: json['admin1'] ?? '',
    );
  }

  @override
  String toString() {
    return 'Location{id: $id, name: $name, latitude: $latitude, longitude: $longitude, elevation: $elevation, featureCode: $featureCode, countryCode: $countryCode, admin1Id: $admin1Id, timezone: $timezone, population: $population, countryId: $countryId, country: $country, admin1: $admin1}';
  }
}
