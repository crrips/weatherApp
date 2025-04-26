// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

import '../widgets/today_chart.dart';
import '../widgets/today_scroll.dart';

class Today extends StatelessWidget {
  const Today({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();
    final temperatures = appState.today?.getTemperatures ?? [];
    final hours = appState.today?.getHours ?? [];
    final windSpeeds = appState.today?.getWindSpeeds ?? [];

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
                TodayChart(hourlyTemperatures: temperatures, hours: hours),
                const SizedBox(height: 16),
                TodayScroll(
                  temperatures: temperatures,
                  hours: hours,
                  windSpeeds: windSpeeds,
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
