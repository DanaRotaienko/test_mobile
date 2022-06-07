import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_mobile/models/numberDto.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'numbers.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE numbers(
          id INTEGER PRIMARY KEY,
          number TEXT
      )
      ''');
  }

  Future<List<NumberDto>> getNumbers() async {
    Database db = await instance.database;
    var numbers = await db.query('numbers', orderBy: 'id DESC');
    List<NumberDto> numbersList = numbers.isNotEmpty
        ? numbers.map((c) => NumberDto.fromMap(c)).toList()
        : [];
    return numbersList;
  }

  static Future<int> add(NumberDto number) async {
    Database db = await instance.database;
    return await db.insert('numbers', number.toMap());
  }
}
