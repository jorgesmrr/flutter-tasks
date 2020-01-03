import 'package:tasks/src/database/task_dao.dart';
import 'package:tasks/src/models/task.dart';

class TaskRepository {
  final TaskDao _taskDao;

  TaskRepository() : _taskDao = TaskDao();

  Future<List<Task>> getTasks(int listId) => _taskDao.getTasks(listId);
  Future saveTask(Task task) => _taskDao.saveTask(task);
  Future updateTask(Task task) => _taskDao.updateTask(task);
  Future deleteTask(Task task) => _taskDao.deleteTask(task);
}
