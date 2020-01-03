import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider dbProvider = DbProvider();

  Database _db;

  get db async {
    if (_db == null) {
      _db = await openDb();
    }

    return _db;
  }

  Future<Database> openDb() async {
    Directory docsDirectory = await getApplicationDocumentsDirectory();
    final path = join(docsDirectory.path, "tasks.db");
    return await openDatabase(path, version: 1, onCreate: initDb);
  }

  void initDb(Database newDb, int version) {
    newDb.execute("""
            CREATE TABLE Lists
              (
                id INTEGER PRIMARY KEY,
                title TEXT
              )
          """);

    newDb.execute("""
            CREATE TABLE Tasks
              (
                id INTEGER PRIMARY KEY,
                list_id INTEGER,
                title TEXT,
                done INTEGER
              )
          """);
  }
}
