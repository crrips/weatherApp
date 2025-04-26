// ignore_for_file: deprecated_member_use

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  final List<double> temperaturesMin;
  final List<double> temperaturesMax;
  final List<String> times;

  const WeeklyChart({
    required this.temperaturesMin,
    required this.temperaturesMax,
    required this.times,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            minY: temperaturesMin.reduce((a, b) => a < b ? a : b) - 1,
            maxY: temperaturesMax.reduce((a, b) => a > b ? a : b) + 6,
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 32,
                  maxIncluded: true,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < times.length) {
                      return Text(
                        times[index],
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                        ),
                      );
                    }
                    return const Text('');
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  minIncluded: false,
                  maxIncluded: false,
                  interval: 4,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}°',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    );
                  },
                  reservedSize: 40,
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 3,
              getDrawingHorizontalLine:
                  (value) => FlLine(
                    color: Colors.grey.withOpacity(0.2),
                    strokeWidth: 1,
                  ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: List.generate(temperaturesMax.length, (index) {
                  return FlSpot(index.toDouble(), temperaturesMax[index]);
                }),
                isCurved: true,
                color: Colors.red,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(0.4),
                      Colors.red.withOpacity(0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: FlDotData(show: false),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFF5252), Color(0xFFFF4081)],
                ),
              ),
              LineChartBarData(
                spots: List.generate(temperaturesMin.length, (index) {
                  return FlSpot(index.toDouble(), temperaturesMin[index]);
                }),
                isCurved: true,
                color: Colors.blue,
                barWidth: 4,
                isStrokeCapRound: true,
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.4),
                      Colors.blue.withOpacity(0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                dotData: FlDotData(show: false),
                gradient: const LinearGradient(
                  colors: [Color(0xFF42A5F5), Color(0xFF64B5F6)],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
