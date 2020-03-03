import 'package:flutter_news_app_bloc/src/models/item_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:flutter_news_app_bloc/src/core/constants.dart';

class DbProvider {
  Database db;

  DbProvider() {
    init();
  }
  init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, DB_NAME);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database database, int version) {
        Batch batch = database.batch();
        batch.execute("""
          CREATE TABLE Items
          (
            id INTEGER PRIMARY KEY,
            by TEXT,
            descendants INTEGER,
            score INTEGER,
            text TEXT,
            time INTEGER,
            title TEXT,
            type TEXT,
            url TEXT,
            kids BLOB,
            deleted INTEGER,
            dead INTEGER,
            parent INTEGER
          )
          """);
        batch.commit();
      },
    );
  }

  insertItem(ItemModel itemModel) {
    return db.insert(
      'Items',
      itemModel.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //insert into Items() values ()
  }

  fetchItem(int id) async {
    //select * from Items where id = :id
    final data = await db.query(
      'Items',
      columns: ['*'],
      where: "id = ?",
      whereArgs: [id],
    );
    if (data == null) {
      return null;
    }

    return ItemModel.fromDb(data.first);
  }
}
