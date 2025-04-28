import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

import '../services/weather_properties.dart';

class Currently extends StatelessWidget {
  const Currently({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Column(
      children: [
        if (appState.lat != null && appState.lon != null) ...[
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              // ignore: deprecated_member_use
                              color: Colors.white.withOpacity(0.15),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                appState.cur?.getTemperature() ?? '',
                                style: const TextStyle(
                                  fontSize: 48,
                                  color: Colors.orangeAccent,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                appState.cur?.getWeatherDescription() ?? '',
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white70,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Icon(
                                WeatherProperties.getWeatherIcon(
                                  appState.cur?.weatherCode ?? 100,
                                ),
                                size: 64,
                                color: WeatherProperties.getWeatherIconColor(
                                  appState.cur?.weatherCode ?? 100,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.air_sharp,
                                    size: 24,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    appState.cur?.getWindspeed() ?? '',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else
          const Text(
            'No location selected',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
      ],
    );
  }
}
