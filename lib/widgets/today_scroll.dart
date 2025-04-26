// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

import '../services/weather_properties.dart';

class TodayScroll extends StatelessWidget {
  final List<String> hours;
  final List<double> temperatures;
  final List<double> windSpeeds;

  const TodayScroll({
    required this.hours,
    required this.temperatures,
    required this.windSpeeds,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: temperatures.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${hours[index]}:00',
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${temperatures[index]}°',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            WeatherProperties.weatherCodeDescriptions[appState
                                    .today
                                    ?.getWeatherCodes[index]] ??
                                'Unknown',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.air_sharp,
                                size: 12,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '${windSpeeds[index]} km/h',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
