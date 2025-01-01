import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quotes_controller.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final QuoteController controller = Get.find<QuoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text('Favorite Quotes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() {
          if (controller.favoriteQuotes.isEmpty) {
            return Center(child: Text('No favorite quotes yet!'));
          }
          return Obx(() {
            return ListView.builder(
              itemCount: controller.favoriteQuotes.length,
              itemBuilder: (context, index) {
                final quote = controller.favoriteQuotes[index];
                return Card(
                  child: ListTile(
                    title: Text(quote.quote,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('- ${quote.author}',
                        style: TextStyle(fontStyle: FontStyle.italic)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        controller.toggleFavorite(quote);
                      },
                    ),
                  ),
                );
              },
            );
          });
        }),
      ),
    );
  }
}
