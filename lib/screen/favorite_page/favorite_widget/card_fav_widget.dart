import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFavWidget extends StatelessWidget {
  const CardFavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Stack( // Use Stack to layer elements like background image, product image, text, and heart icon
        children: [
          // Background Swirl Graphic (can be an Image.asset or CustomPaint)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.brown[50], // Placeholder color
                borderRadius: BorderRadius.circular(15),
                // Add image decoration for the swirl graphic
                image: DecorationImage(
                  image: AssetImage('asset/image/main_image.jpg'), // Your swirl image
                  fit: BoxFit.fill,
                  alignment: Alignment.bottomRight, // Adjust as needed
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  'Ferrero Rocher Nuts',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Delicious Box', // Example description
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                Spacer(), // Pushes the heart icon to the bottom
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: Icon(Icons.favorite_border), // or Icons.favorite if already favourited
                    color: Colors.red, // Or another color
                    onPressed: () {
                      // Toggle favourite status
                    },
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
