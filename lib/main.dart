import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:online_payment/screen/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initEnv();
  runApp(const MyApp());
}

/// Initialize environment variables from .env file
/// If .env file is not found, continue without it
Future<void> _initEnv() async {
  try {
    await dotenv.load(fileName: '.env');
    debugPrint('✅ Loaded environment variables from .env');
  } catch (e) {
    debugPrint('⚠️ Could not load .env file: $e');
    debugPrint('ℹ️ Ensure .env file exists in project root');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomeScreen(),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.blueGrey,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(color: Colors.white70, fontSize: 18),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}
