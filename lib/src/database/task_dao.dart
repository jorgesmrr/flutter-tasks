import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/resources/db_provider.dart';

class TaskDao {
  final dbProvider = DbProvider.dbProvider;

  Future<List<Task>> getTasks(int listId) async {
    final db = await dbProvider.db;
    final records = await db.query(
      "Tasks",
      columns: null,
      where: 'list_id = ?',
      whereArgs: [listId],
    );

    return records.map((record) => Task.fromMap(record)).toList().cast<Task>();
  }

  Future saveTask(Task task) async {
    final db = await dbProvider.db;
    return db.insert("Tasks", task.toMap());
  }

  Future updateTask(Task task) async {
    final db = await dbProvider.db;
    return db.update(
      "Tasks",
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future deleteTask(Task task) async {
    final db = await dbProvider.db;
    return db.delete(
      "Tasks",
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
