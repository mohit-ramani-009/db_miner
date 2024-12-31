import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quotes_controller.dart';

class FavoritesScreen extends StatelessWidget {
  final QuoteController controller = Get.find<QuoteController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Quotes'),
      ),
      body: Obx(() {
        if (controller.favoriteQuotes.isEmpty) {
          return Center(child: Text('No favorite quotes yet!'));
        }

        return ListView.builder(
          itemCount: controller.favoriteQuotes.length,
          itemBuilder: (context, index) {
            final quote = controller.favoriteQuotes[index];
            return ListTile(
              title: Text(quote.quote),
              subtitle: Text('- ${quote.author}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  controller.toggleFavorite(quote); // Remove from favorites
                },
              ),
            );
          },
        );
      }),
    );
  }
}
