import 'package:chocolate_store/screen/sign_in_up_screen/sign_in_up_page.dart';
import 'package:flutter/material.dart';

class ChocolateIntroScreen extends StatelessWidget {
  const ChocolateIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background color or image

          Positioned.fill(

            child: Image.asset(
              'asset/image/Gemini_Generated_Image_fyivy1fyivy1fyiv.png',
              fit: BoxFit.cover,
              height: 850,
            ),
          ),
          // Skip button at the top right
          Positioned(
            top: 40,
            right: 24,
            child: TextButton(
              onPressed: () {
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
          // Back button at the top left
          Positioned(
            top: 40,
            left: 24,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                // Handle back
              },
            ),
          ),
          // Bottom text and button
          // Bottom text and button with clear separation
          Positioned(
            left: 32,
            right: 32,
            top: 600, // adjust this value up/down as you like
            child: Text(
              'نحاول أن نجعل كل قضمة من الشوكولا تجربة ساحرة\n تأخذك بعيدًا عن الواقع، لتعيش لحظات من السعادة والدفء\n في عالم من الحب والشوكولا',
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
                          return SignInPage();
                        }),
                  );
                },
                child: const Text(
                  'التـالـي',
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