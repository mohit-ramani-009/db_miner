import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/quotes.dart';

class QuoteService {
  static const String _url = "https://dummyjson.com/quotes/";

  Future<List<Quote>> fetchQuotes() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body)['quotes'];
      return jsonData.map((quoteJson) => Quote.fromJson(quoteJson)).toList();
    } else {
      throw Exception('Failed to load quotes');
    }
  }
}
