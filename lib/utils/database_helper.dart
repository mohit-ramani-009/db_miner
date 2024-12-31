import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/quotes.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quotes.db');
    return _database!;
  }

  Future<Database> _initDB(String path) async {
    final dbPath = await getDatabasesPath();
    final dbLocation = join(dbPath, path);
    return await openDatabase(dbLocation, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE quotes ( 
      id $idType, 
      quote $textType, 
      author $textType)
    ''');
  }

  // Insert a new quote
  Future<int> insertQuote(Quote quote) async {
    final db = await instance.database;
    return await db.insert('quotes', quote.toJson());
  }

  // Fetch all quotes
  Future<List<Quote>> fetchAllQuotes() async {
    final db = await instance.database;
    final result = await db.query('quotes');
    return result.map((json) => Quote.fromJson(json)).toList();
  }

  // Delete quote by ID
  Future<int> deleteQuote(int id) async {
    final db = await instance.database;
    return await db.delete('quotes', where: 'id = ?', whereArgs: [id]);
  }
}
