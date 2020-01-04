import 'package:rxdart/rxdart.dart';
import 'package:tasks/src/models/tasks_list.dart';
import 'package:tasks/src/resources/tasks_list_repository.dart';

class AppBloc {
  final TasksListRepository _repository = TasksListRepository();

  final _activeList = BehaviorSubject<int>();
  final _lists = BehaviorSubject<List<TasksList>>();
  final _allowToAddTasks = BehaviorSubject<bool>();

  ValueStream<int> get activeList => _activeList.stream;
  ValueStream<List<TasksList>> get lists => _lists.stream;
  ValueStream<bool> get allowToAddTasks => _allowToAddTasks.stream;

  AppBloc() {
    _lists.listen((lists) {
      if (!activeList.hasValue) {
        goToList(lists.first.id);
      }
    });
  }

  goToList(int id) => _activeList.add(id);

  readLists() async => _lists.add(await _repository.getLists());

  addList(String title) async {
    final list = TasksList(title);
    await _repository.saveList(list);

    readLists();
  }

  allowAddTasks() => _allowToAddTasks.add(true);
  blockAddTasks() => _allowToAddTasks.add(false);
}
