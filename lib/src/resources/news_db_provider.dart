import 'dart:io';

import '../../src/models/cache.dart';
import '../../src/models/item.dart';
import '../../src/models/source.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NewsDbProvider implements Source, Cache {
  Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
        CREATE TABLE Items 
        (
          id INTEGER PRIMARY KEY,
          deleted INTEGER,
          type TEXT,
          by TEXT,
          time INTEGER,
          text TEXT,
          dead INTEGER,
          parent INTEGER,
          poll INTEGER,
          kids BLOB,
          url TEXT,
          score INTEGER,
          title TEXT,
          parts INTEGER,
          descendants INTEGER
        )
        """);
    });
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      "items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );

    if (maps.length > 0) {
      ItemModel.fromDb(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert("items", item.toMapForSql());
  }

  @override
  Future<List<int>> fetchTopIds() => null;
}

final newsDbProvider = NewsDbProvider();
