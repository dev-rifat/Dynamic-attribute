import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'module/home/provider/api_provider.dart';
import 'module/starting/screen/splash_screen.dart';
import 'module/starting/splash_provider/splash_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProvider(create: (_) => SplashProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
