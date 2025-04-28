// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

import '../services/weather_properties.dart';

class WeeklyScroll extends StatelessWidget {
  final List<String> times;
  final List<double> temperaturesMin;
  final List<double> temperaturesMax;
  final List<int> weather;

  const WeeklyScroll({
    required this.times,
    required this.temperaturesMin,
    required this.temperaturesMax,
    required this.weather,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: temperaturesMin.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    width: 120,
                    margin: const EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            times[index],
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${temperaturesMin[index]}°',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${temperaturesMax[index]}°',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          // Text(
                          //   '${temperaturesMax[index]}°',
                          //   style: const TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.red,
                          //   ),
                          // ),
                          // Text(
                          //   '${temperaturesMin[index]}°',
                          //   style: const TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.blue,
                          //   ),
                          // ),
                          const SizedBox(height: 8),
                          Icon(
                            WeatherProperties.getWeatherIcon(weather[index]),
                            size: 24,
                            color: WeatherProperties.getWeatherIconColor(
                              weather[index],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            WeatherProperties
                                    .weatherCodeDescriptions[weather[index]] ??
                                'Unknown',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
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
