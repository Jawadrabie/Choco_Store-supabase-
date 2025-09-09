import 'package:chocolate_store/screen/splash_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../home_page_screen/home_page.dart';
import '../sign_in_up_screen/sign_in_up_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // This controls the duration the splash screen appears (here: 3 seconds)
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) =>
        HomePage(),
           // ChocoIntroScreen()

        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'asset/image/first_splash_screen.png', // Replace with your image path
            fit: BoxFit.cover,
          ),
          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          // Centered logo and text
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // App name styled as in your example
                Text(
                  'Mocha Muse',
                  style: TextStyle(
                    fontFamily: 'YourCustomFont',
                    // Replace with your font if needed
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black38,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Tagline
                Text(
                  'LUXURY CHOCOLATES',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    letterSpacing: 3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
