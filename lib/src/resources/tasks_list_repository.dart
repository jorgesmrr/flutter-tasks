import 'package:tasks/src/database/tasks_list_dao.dart';
import 'package:tasks/src/models/tasks_list.dart';

class TasksListRepository {
  final TasksListDao _tasksListDao;

  TasksListRepository() : _tasksListDao = TasksListDao();

  Future<List<TasksList>> getLists() => _tasksListDao.getLists();
  Future saveList(TasksList list) => _tasksListDao.saveList(list);
}
