import 'package:flutter/material.dart';
import '../model/quotes.dart';

class DetailScreen extends StatelessWidget {
  final Quote quote;

  DetailScreen({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
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
            animation: AlwaysStoppedAnimation<double>(1.0),
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            quote.quote,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 500),
                        opacity: 1.0,
                        child: Center(
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
                      ),
                      SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
