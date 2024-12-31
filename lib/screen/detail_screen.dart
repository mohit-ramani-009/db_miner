import 'package:flutter/material.dart';
import '../model/quotes.dart'; // Assuming you have a Quote model

class DetailScreen extends StatelessWidget {
  final Quote quote;
  DetailScreen({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quote Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.cyan,
        elevation: 4,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: AlwaysStoppedAnimation<double>(1.0), // For smoother animation
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Quote Text with a more stylish font and smooth appearance
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: 1.0,
                      child: Text(
                        quote.quote,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Author Name with some extra spacing and lighter color
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 500),
                      opacity: 1.0,
                      child: Text(
                        '- ${quote.author}',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 40),

                    // "Mark as Favorite" button with better style
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Add any action for the button here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan, // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                          elevation: 5,
                        ),
                        child: Text(
                          'Mark as Favorite',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
