import 'package:chocolate_store/screen/splash_screen/welcome2_screen.dart';
import 'package:flutter/material.dart';
import '../sign_in_up_screen/sign_in_up_page.dart';

class ChocoIntroScreen extends StatelessWidget {
  const ChocoIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image (replace with your asset)
          Positioned.fill(
            child: Image.asset(
              'asset/image/splashh.png',
              fit: BoxFit.cover,
            ),
          ),
          // "chocolate" text at the top center (if needed)
          Positioned(
            top: 175,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'شـوكـولا مـزاج',
                style: TextStyle(
                color:   Colors.white,
                  fontSize: 60,
                  // fontWeight: FontWeight.bold,

                  // shadows: [
                  //   Shadow(
                  //     blurRadius: 8,
                  //     color: Colors.black38,
                  //     offset: Offset(2, 2),
                  //   ),
                  // ],
                ),
              ),
            ),
          ),
          // Skip button
          Positioned(
            top: 40,
            right: 24,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) {
                          return  SignInPage();
                        }),
                  );
              },
              child: Text(
                'تخطي',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                      blurRadius: 6,
                      color: Colors.black45,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Move welcome text higher (e.g. 350 pixels from top)
          Positioned(
            left: 32,
            right: 32,
            top: 600, // adjust this value up/down as you like
            child: Text(
              '!مرحباً بكم في متجر مزاج، خياركم الأول للسعادة',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black45,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          // Next button stays at the bottom
          Positioned(
            left: 32,
            right: 32,
            bottom: 60,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:Color(0xFF230B02) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) {
                          return  CookiesIntroScreen();
                        }),
                  );
                },
                child: const Text(
                  'التالي',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}