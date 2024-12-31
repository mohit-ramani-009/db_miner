import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/quotes.dart';
import '../utils/database_helper.dart';
import '../utils/api_service.dart';

class QuoteController extends GetxController {
  var quotes = <Quote>[].obs; // All quotes (fetched)
  var favoriteQuotes = <Quote>[].obs; // Filtered list of favorites
  var favoriteIds = <int>[].obs; // List of favorite quote IDs

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final QuoteService _quoteService = QuoteService();

  @override
  void onInit() {
    super.onInit();
    loadQuotes(); // Load all quotes from DB or API
    loadFavorites(); // Load favorite quotes from SharedPreferences and DB
  }

  // Load all quotes from the database or API
  void loadQuotes() async {
    final storedQuotes = await _dbHelper.fetchAllQuotes();
    if (storedQuotes.isNotEmpty) {
      quotes.value = storedQuotes;
    } else {
      fetchQuotesFromAPI();
    }
  }

  // Fetch quotes from API and save them to the database
  void fetchQuotesFromAPI() async {
    try {
      final fetchedQuotes = await _quoteService.fetchQuotes();
      for (var quote in fetchedQuotes) {
        await _dbHelper.insertQuote(quote);
      }
      quotes.value = fetchedQuotes;
    } catch (e) {
      print("Error fetching quotes: $e");
    }
  }

  // Load favorite quotes from SharedPreferences and sync with DB
  void loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteIdsList = prefs.getStringList('favorite_ids') ?? [];
    favoriteIds.value = favoriteIdsList.map((id) => int.parse(id)).toList();

    final allQuotes = await _dbHelper.fetchAllQuotes();
    favoriteQuotes.value = allQuotes.where((quote) {
      return favoriteIds.contains(quote.id);
    }).toList();
  }

  // Toggle a quote's favorite status (add or remove)
  void toggleFavorite(Quote quote) async {
    final prefs = await SharedPreferences.getInstance();
    if (favoriteIds.contains(quote.id)) {
      favoriteIds.remove(quote.id);
      await _dbHelper.deleteQuote(quote.id);
    } else {
      favoriteIds.add(quote.id);
      await _dbHelper.insertQuote(quote);
    }
    await prefs.setStringList('favorite_ids', favoriteIds.map((id) => id.toString()).toList());
    loadFavorites();
  }

  // Check if a quote is in the favorites list
  bool isFavorite(int id) {
    return favoriteIds.contains(id);
  }
}
