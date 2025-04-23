import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/services/location_service.dart';

import 'package:weather_app/core/app_state.dart';

Future<void> handleLocationPressed(BuildContext context) async {
  final appState = Provider.of<AppState>(context, listen: false);
  final locationService = LocationService();

  if (appState.isGeoPressed) {
    appState.disableGeo();
  } else {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    String? position = await locationService.determinePosition();
    if (position == null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Location permission denied.')),
      );
      return;
    }

    final parts = position.split(', ');

    appState.enableGeo(parts[0], parts[1]);

    appState.updateWeather();
  }
}
