import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/quotes.dart';
import '../utils/database_helper.dart';
import '../utils/api_service.dart';

class QuoteController extends GetxController {
  var quotes = <Quote>[].obs;
  RxList<int> favoriteIds = <int>[].obs;
  RxList<Quote> favoriteQuotes = <Quote>[].obs;

  final DatabaseHelper _dbHelper = DatabaseHelper.instance;
  final QuoteService _quoteService = QuoteService();

  @override
  void onInit() {
    super.onInit();
    loadQuotes();
    loadFavorites();
  }

  void loadQuotes() async {
    final storedQuotes = await _dbHelper.fetchAllQuotes();
    if (storedQuotes.isNotEmpty) {
      quotes.value = storedQuotes;
    } else {
      fetchQuotesFromAPI();
    }
  }

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

  void loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final favoriteIdsList = prefs.getStringList('favorite_ids') ?? [];
      favoriteIds.value = favoriteIdsList.map((id) => int.parse(id)).toList();

      final allQuotes = await _dbHelper.fetchAllQuotes();
      favoriteQuotes.value = allQuotes.where((quote) {
        return favoriteIds.contains(quote.id);
      }).toList();
    } catch (e) {
      print('Error loading favorites: $e');
    }
  }

  void toggleFavorite(Quote quote) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      if (favoriteIds.contains(quote.id)) {
        favoriteIds.remove(quote.id);
        await _dbHelper.deleteQuote(quote.id);
      } else {
        favoriteIds.add(quote.id);
        await _dbHelper.insertQuote(quote);
      }

      await prefs.setStringList(
          'favorite_ids', favoriteIds.map((id) => id.toString()).toList());

      loadFavorites();
    } catch (e) {
      print('Error toggling favorite: $e');
    }
  }

  bool isFavorite(int id) {
    return favoriteIds.contains(id);
  }
}
