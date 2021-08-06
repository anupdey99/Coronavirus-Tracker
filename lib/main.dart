import 'package:coronavirus_tracker/app/repositories/data_repository.dart';
import 'package:coronavirus_tracker/app/services/api_keys.dart';
import 'package:coronavirus_tracker/app/services/data_cache_service.dart';
import 'package:coronavirus_tracker/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './app/services/api_service.dart';
import './app/services/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Default local set
  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  final preferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    preferences: preferences,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.preferences}) : super(key: key);
  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
          apiService: APIService(API.sandbox()),
          dataCacheService: DataCacheService(preferences: preferences)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
