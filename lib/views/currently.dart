import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

class Currently extends StatelessWidget {
  const Currently({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (appState.lat != null && appState.lon != null) ...[
              Text(
                appState.cur?.getTemperature() ?? '',
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                appState.cur?.getWeatherDescription() ?? '',
                style: const TextStyle(fontSize: 24, color: Colors.white70),
              ),
              const SizedBox(height: 4),
              Icon(
                appState.cur?.getWeatherIcon(),
                size: 64,
                color: appState.cur?.getWeatherIconColor(),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.air_sharp, size: 24, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    appState.cur?.getWindspeed() ?? '',
                    style: const TextStyle(fontSize: 24, color: Colors.white70),
                  ),
                ],
              ),
            ] else
              const Text(
                'No location selected',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
