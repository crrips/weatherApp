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
    return BottomAppBar(
      color: Colors.white70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavBarItem(0, Icons.sunny, 'Currently'),
          _buildNavBarItem(1, Icons.calendar_today, 'Today'),
          _buildNavBarItem(2, Icons.calendar_view_week_outlined, 'Weekly'),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon, String label) {
    bool isSelected = widget.tabController.index == index;
    return TextButton(
      onPressed: () {
        widget.tabController.animateTo(index);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
            color: isSelected ? Colors.blueAccent : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
