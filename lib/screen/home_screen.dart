import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/quotes_controller.dart';

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
        title: Text('Quotes'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Get.toNamed('/favorites'); // Navigate to the favorites screen
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.quotes.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: controller.quotes.length,
          itemBuilder: (context, index) {
            final quote = controller.quotes[index];
            return ListTile(
              title: Text(quote.quote),
              subtitle: Text('- ${quote.author}'),
              trailing: Obx(() {
                return IconButton(
                  icon: Icon(
                    controller.isFavorite(quote.id) ? Icons.favorite : Icons
                        .favorite_border,
                    color: controller.isFavorite(quote.id) ? Colors.red : Colors
                        .grey,
                  ),
                  onPressed: () {
                    setState(() {
                      controller.toggleFavorite(
                          quote); // Toggle favorite status
                    });
                  },
                );
              }),
            );
          },
        );
      }),
    );
  }
}
