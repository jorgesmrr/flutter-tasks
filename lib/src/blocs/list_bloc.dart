import 'package:rxdart/rxdart.dart';
import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/resources/task_repository.dart';

class ListBloc {
  final int _listId;
  final TaskRepository _repository = TaskRepository();

  final _tasks = BehaviorSubject<List<Task>>();

  ListBloc(int listId) : _listId = listId;

  get tasks => _tasks.stream;

  readTasks() async => _tasks.add(await _repository.getTasks(_listId));

  addTask(String title) async {
    final task = Task(_listId, title);
    await _repository.saveTask(task);

    readTasks();
  }

  toggleTask(Task task) async {
    task.done = !(task.done ?? false);
    await _repository.updateTask(task);

    readTasks();
  }

  deleteTask(Task task) async {
    await _repository.deleteTask(task);

    readTasks();
  }
}
