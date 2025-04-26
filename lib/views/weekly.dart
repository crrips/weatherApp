import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

import '../widgets/weekly_chart.dart';
import '../widgets/weekly_scroll.dart';

class Weekly extends StatelessWidget {
  const Weekly({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (appState.lat != null &&
                  appState.lon != null &&
                  appState.weekly != null) ...[
                WeeklyChart(
                  temperaturesMin: appState.weekly!.getTemperaturesMin,
                  temperaturesMax: appState.weekly!.getTemperaturesMax,
                  times: appState.weekly!.getTimes,
                ),
                const SizedBox(height: 16),
                WeeklyScroll(
                  temperaturesMin: appState.weekly!.getTemperaturesMin,
                  temperaturesMax: appState.weekly!.getTemperaturesMax,
                  times: appState.weekly!.getTimes,
                  weather: appState.weekly!.getWeatherCodes,
                ),
                // Text(
                //   appState.weeklyWeatherText ?? 'No data available',
                //   style: const TextStyle(fontSize: 18),
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
