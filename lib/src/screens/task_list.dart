import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_bloc.dart';
import 'package:tasks/src/blocs/app_provider.dart';
import 'package:tasks/src/blocs/list_bloc.dart';
import 'package:tasks/src/blocs/list_provider.dart';
import 'package:tasks/src/models/task.dart';

class TasksListWidget extends StatelessWidget {
  Widget build(context) {
    final AppBloc appBloc = AppProvider.of(context);
    final ListBloc listBloc = ListProvider.of(context);

    return StreamBuilder(
      stream: appBloc.allowToAddTasks,
      builder: (context, snapshot) {
        if (snapshot.data ?? false) {
          return Column(children: <Widget>[
            Expanded(child: buildTasksList(listBloc)),
            buildNewTaskForm(appBloc, listBloc),
          ]);
        }

        return buildTasksList(listBloc);
      },
    );
  }

  Widget buildTasksList(ListBloc bloc) {
    return StreamBuilder(
      stream: bloc.tasks,
      builder: (context, AsyncSnapshot<List<Task>> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }

        final tasks = snapshot.data;

        return ListView.separated(
          itemCount: tasks.length,
          itemBuilder: (context, index) =>
              buildTaskListItem(bloc, tasks[index]),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        );
      },
    );
  }

  Widget buildTaskListItem(ListBloc bloc, Task task) {
    return Dismissible(
      key: Key('${task.id}'),
      onDismissed: (_) => bloc.deleteTask(task),
      child: ListTile(
        leading: IconButton(
          icon: Icon(
            task.done ? Icons.check_circle : Icons.check_circle_outline,
            color: task.done ? Colors.blue : null,
          ),
          onPressed: () => bloc.toggleTask(task),
        ),
        title: Text(
          task.title,
          style: task.done
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        ),
      ),
    );
  }

  Widget buildNewTaskForm(AppBloc appBloc, ListBloc listBloc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(children: <Widget>[
        Icon(Icons.add),
        Expanded(
          child: TextField(
            autofocus: true,
            onSubmitted: (String value) {
              listBloc.addTask(value);
              appBloc.blockAddTasks();
            },
          ),
        ),
      ]),
    );
  }
}
