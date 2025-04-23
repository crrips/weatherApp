import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_state.dart';

class Today extends StatelessWidget {
  const Today({super.key});

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
              if (appState.lat != null && appState.lon != null)
                Text(
                  appState.todayWeatherText ?? 'No data available',
                  style: const TextStyle(fontSize: 24),
                )
              else
                const Text(
                  'No location selected',
                  style: TextStyle(fontSize: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
