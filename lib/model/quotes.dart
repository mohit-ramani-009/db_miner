class Quote {
  final int id;
  final String quote;
  final String author;

  Quote({
    required this.id,
    required this.quote,
    required this.author,
  });

  // From JSON to Quote
  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'],
      quote: json['quote'],
      author: json['author'],
    );
  }

  // From Quote to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quote': quote,
      'author': author,
    };
  }
}
