import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/fetch_data.dart';
import '../core/app_state.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback onSearchTap;
  final Future<void> Function() onLocationPressed;

  const CustomAppBar({
    required this.onSearchTap,
    required this.onLocationPressed,
    super.key,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final FetchData fetchData = FetchData();
  final TextEditingController _controller = TextEditingController();

  List<String> _locations = [];
  String? _selectedLocation;

  bool _showSuggestions = false;

  bool isHidden = false;

  List<String> _coordinates = [];

  void _onTextChanged(String query) async {
    final trimmed = query.trim();
    if (trimmed.length > 1) {
      final locs = await fetchData.fetchLocations(trimmed);
      final locStrs =
          locs
              .map(
                (location) =>
                    '${location.name}, ${location.admin1}, ${location.country}',
              )
              .toList();

      final coordinates =
          locs
              .map((location) => '${location.latitude}, ${location.longitude}')
              .toList();

      // debugPrint('Locations: $locStrs');

      if (mounted) {
        setState(() {
          _locations = locStrs;
          _coordinates = coordinates;
          if (_locations.isNotEmpty) {
            if (_controller.text.isEmpty) {
              _locations = [];
            }
            _showSuggestions = true;
          }
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _locations = [];
          _coordinates = [];
          _showSuggestions = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    if (appState.isGeoPressed) {
      setState(() {
        _selectedLocation = null;
      });
    }

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(8, 16, 8, 12),
      child: SafeArea(
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              decoration: InputDecoration(
                hintText: 'Search location...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.my_location),
                  onPressed: widget.onLocationPressed,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (String value) async {
                if (_locations.isNotEmpty && _coordinates.isNotEmpty) {
                  _controller.text = '';
                  _selectedLocation = _locations.first;
                  _locations = [];

                  appState.enableSearch(
                    _coordinates.first.split(', ')[0],
                    _coordinates.first.split(', ')[1],
                  );

                  appState.updateWeather();

                  setState(() {
                    _showSuggestions = false;
                  });
                } else {
                  _selectedLocation = 'Couldn\'t find location';
                  _controller.text = '';
                  _locations = [];
                  _coordinates = [];

                  appState.clearWeather();

                  setState(() {
                    _showSuggestions = false;
                  });
                }
              },
            ),
            if (_showSuggestions && _locations.isNotEmpty)
              Container(
                margin: const EdgeInsets.only(top: 8),
                constraints: const BoxConstraints(maxHeight: 250),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _locations.length,
                  itemBuilder: (context, index) {
                    if (_locations.first == 'Error, Error, Error') {
                      isHidden = true;
                      return const ListTile(
                        title: Text('Error fetching locations'),
                      );
                    }
                    final item = _locations[index];
                    isHidden = false;
                    return ListTile(
                      title: Text(item),
                      onTap: () async {
                        _controller.text = '';
                        _selectedLocation = item;
                        _locations = [];

                        appState.enableSearch(
                          _coordinates[index].split(', ')[0],
                          _coordinates[index].split(', ')[1],
                        );

                        appState.updateWeather();

                        setState(() {
                          _showSuggestions = false;
                        });
                      },
                    );
                  },
                ),
              ),
            if (_selectedLocation != null &&
                appState.isGeoPressed == false &&
                !isHidden) ...[
              const SizedBox(height: 16),
              Text(
                _selectedLocation ?? '',
                style: const TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ] else if (appState.isGeoPressed == true) ...[
              const SizedBox(height: 16),
              if (appState.apiFail == null)
                Text('Current location', style: const TextStyle(fontSize: 24)),
              if (appState.apiFail != null)
                Text(appState.apiFail ?? '', style: TextStyle(fontSize: 24)),
            ],
          ],
        ),
      ),
    );
  }
}
