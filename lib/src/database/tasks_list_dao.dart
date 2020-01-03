import 'package:tasks/src/models/tasks_list.dart';
import 'package:tasks/src/resources/db_provider.dart';

class TasksListDao {
  final dbProvider = DbProvider.dbProvider;

  Future<List<TasksList>> getLists() async {
    final db = await dbProvider.db;
    final records = await db.query(
      "Lists",
      columns: null,
    );

    return records
        .map((record) => TasksList.fromMap(record))
        .toList()
        .cast<TasksList>();
  }

  Future saveList(TasksList list) async {
    final db = await dbProvider.db;
    return db.insert("Lists", list.toMap());
  }
}
