import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quotes_controller.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuoteController controller = Get.put(QuoteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quotes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              Get.toNamed('/favorites'); // Navigate to the favorites screen
            },
          ),
        ],
        elevation: 2,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.grey[200], // Light background color
        child: Obx(() {
          if (controller.quotes.isEmpty) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.cyan,
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: controller.quotes.length,
            itemBuilder: (context, index) {
              final quote = controller.quotes[index];
              return Card(
                elevation: 4,
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    quote.quote,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      '- ${quote.author}',
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  onTap: () {
                    // Navigate to DetailScreen with animation
                    Get.to(
                      DetailScreen(quote: quote),
                      transition: Transition.fadeIn,
                      duration: Duration(milliseconds: 500),
                    );
                  },
                  trailing: Obx(() {
                    return IconButton(
                      icon: Icon(
                        controller.isFavorite(quote.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isFavorite(quote.id)
                            ? Colors.redAccent
                            : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          controller.toggleFavorite(quote); // Toggle favorite status
                        });
                      },
                    );
                  }),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
