import 'package:assignment_wem_pro/module/home/view/screen/attribute_screen.dart';
import 'package:assignment_wem_pro/utils/app_color.dart';
import 'package:assignment_wem_pro/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../splash_provider/splash_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Call loadData when the screen is built
    Future.microtask(() => Provider.of<SplashProvider>(context, listen: false).loadData());

    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Consumer<SplashProvider>(
        builder: (context, splashProvider, child) {
          // If splash is finished, navigate to home screen
          if (splashProvider.isSplashFinished) {
            // Navigate to home screen and remove splash screen from navigation stack
            Future.microtask(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AttributeScreen()),
            ));
          }
          // Display splash screen content (e.g., App name and progress indicator)
          return  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Assignment",style: AppStyle.titleText24.copyWith(color: AppColor.backgroundColor),), // Replace with your logo
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: AppColor.backgroundColor,),
              ],
            ),
          );
        },
      ),
    );
  }
}
