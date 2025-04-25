// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

import '../widgets/today_chart.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final temperatures = appState.today?.getTemperatures ?? [];
    final hours = appState.today?.getHours ?? [];
    final windSpeeds = appState.today?.getWindSpeeds ?? [];
    final weather = appState.today?.getWeatherCodes ?? [];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (appState.lat != null &&
                  appState.lon != null &&
                  appState.today != null) ...[
                TodayChart(
                  hourlyTemperatures: temperatures,
                  hours: hours,
                ),
                Column(
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
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.2),
                                  ),
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
                                        appState
                                                .today!
                                                .weatherCodeDescriptions[weather[index]] ??
                                            'Unknown',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                ),
                // Text(
                //   appState.todayWeatherText ?? 'No data available',
                //   style: const TextStyle(fontSize: 24, color: Colors.white),
                // ),
              ] else
                const Text(
                  'No location selected',
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
