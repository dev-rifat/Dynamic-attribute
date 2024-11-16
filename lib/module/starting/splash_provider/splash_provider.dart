import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashProvider with ChangeNotifier {
  bool isSplashFinished = false;

  // Function to simulate loading or initializing tasks
  void loadData() async {
    await Future.delayed(const Duration(seconds: 3)); // Simulate a loading delay
    isSplashFinished = true;
    notifyListeners(); // Notify listeners to trigger navigation
  }
}
