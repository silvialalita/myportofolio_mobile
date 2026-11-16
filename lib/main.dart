import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}