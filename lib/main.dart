import 'package:flutter/material.dart';
import 'package:opentag_frontend/app.dart';
import 'package:opentag_frontend/data/settings_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SettingsService();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.limeAccent.shade700),
        useMaterial3: true,
      ),
      home: const App(),
    );
  }
}
