import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

/// Widget root aplikasi: membungkus seluruh app dengan [MaterialApp]
/// (tema Material 3 dan halaman awal [MyHomePage]).
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false,
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black, primary: const Color.fromARGB(255, 108, 9, 157))
        .copyWith(
        primary: const Color.fromARGB(255, 146, 12, 213),
        onPrimary: const Color(0xFFFAF5ED),
        secondary:const Color(0xFFb82aff),
        onSecondary: const Color(0xFF1f1f1f),
        tertiary: const Color(0xFFffed2a),
        onTertiary: const Color.fromRGBO(31, 31, 31, 1),

        surface: const Color(0xFF000000),
        onSurface: const Color(0xFFFAF5ED),
        onSurfaceVariant: const Color.fromARGB(255, 72, 72, 72),
        outline: const Color.fromARGB(255, 72, 72, 72),
        error: const Color.fromARGB(255, 184, 0, 0),
      ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}