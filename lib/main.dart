import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/location_service.dart';
import 'services/fetch_data.dart';
import 'services/gps_button.dart';

import 'views/currently.dart';
import 'views/today.dart';
import 'views/weekly.dart';

import 'widgets/top_bar.dart';
import 'widgets/bottom_bar.dart';

import 'core/app_state.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AppState(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      home: const HomePage(title: 'Weather App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ValueNotifier<List<String>> locationSuggestions = ValueNotifier([]);

  final LocationService locationService = LocationService();
  final FetchData fetchData = FetchData();

  String? locationText;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.asset('assets/images/bg.jpg').image,
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomAppBar(
                onSearchTap: () {
                  appState.toggleGeoPressed();
                },
                onLocationPressed: () => handleLocationPressed(context),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [Currently(), Today(), Weekly()],
                ),
              ),
              BottomBar(tabController: _tabController),
            ],
          ),
        ),
      ),
    );
  }
}
