import 'package:rxdart/rxdart.dart';
import 'package:tasks/src/models/task.dart';
import 'package:tasks/src/resources/task_repository.dart';

class ListBloc {
  final ValueStream<int> _listId;
  final TaskRepository _repository = TaskRepository();

  final _tasks = BehaviorSubject<List<Task>>();

  ListBloc(ValueStream<int> listId) : _listId = listId {
    _listId.listen((_) => _readTasks());
  }

  get tasks => _tasks.stream;

  _readTasks() async => _tasks.add(await _repository.getTasks(_listId.value));

  addTask(String title) async {
    final task = Task(_listId.value, title);
    await _repository.saveTask(task);

    _readTasks();
  }

  toggleTask(Task task) async {
    task.done = !(task.done ?? false);
    await _repository.updateTask(task);

    _readTasks();
  }

  deleteTask(Task task) async {
    await _repository.deleteTask(task);

    _readTasks();
  }
}
