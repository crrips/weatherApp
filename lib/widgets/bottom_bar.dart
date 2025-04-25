// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  final TabController tabController;

  const BottomBar({super.key, required this.tabController});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                height: 72,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                color: Colors.grey.withOpacity(0.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildNavBarItem(0, Icons.sunny, 'Currently'),
                    _buildNavBarItem(1, Icons.calendar_today, 'Today'),
                    _buildNavBarItem(
                      2,
                      Icons.calendar_view_week_outlined,
                      'Weekly',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    return AnimatedBuilder(
      animation: widget.tabController.animation!,
      builder: (context, child) {
        final selectedIndex = widget.tabController.animation!.value;
        final t = (1.0 - (selectedIndex - index).abs()).clamp(0.0, 1.0);

        final changeColor = Color.lerp(Colors.white70, Colors.blueAccent, t);

        return TextButton(
          onPressed: () {
            widget.tabController.animateTo(index);
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 36, color: changeColor),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(fontSize: 14, color: changeColor),
                child: Text(label),
              ),
            ],
          ),
        );
      },
    );
  }
}
