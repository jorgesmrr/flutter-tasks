import 'package:rxdart/rxdart.dart';
import 'package:tasks/src/models/tasks_list.dart';
import 'package:tasks/src/resources/tasks_list_repository.dart';

class AppBloc {
  final TasksListRepository _repository = TasksListRepository();

  final _activeList = BehaviorSubject<int>.seeded(1);
  final _lists = BehaviorSubject<List<TasksList>>();

  get activeList => _activeList.stream;
  get lists => _lists.stream;

  goToList(int id) => _activeList.add(id);

  readLists() async => _lists.add(await _repository.getLists());

  addList(String title) async {
    final list = TasksList(title);
    await _repository.saveList(list);

    readLists();
  }
}
