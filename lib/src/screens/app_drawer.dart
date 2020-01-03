import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_bloc.dart';
import 'package:tasks/src/blocs/app_provider.dart';
import 'package:tasks/src/models/tasks_list.dart';

class AppDrawer extends StatelessWidget {
  Widget build(context) {
    AppBloc bloc = AppProvider.of(context);

    bloc.readLists();

    return Drawer(
      child: StreamBuilder(
        stream: bloc.lists,
        builder: (context, AsyncSnapshot<List<TasksList>> snapshot) {
          return Column(children: <Widget>[
            Expanded(
                child: snapshot.hasData
                    ? buildList(bloc, snapshot.data)
                    : Text('Loading...')),
            buildNewListForm(bloc)
          ]);
        },
      ),
    );
  }

  Widget buildList(AppBloc bloc, List<TasksList> lists) {
    return ListView.separated(
      itemCount: lists.length,
      itemBuilder: (context, index) {
        return buildTasksListItem(bloc, lists[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildTasksListItem(AppBloc bloc, TasksList list) {
    return StreamBuilder(
      stream: bloc.activeList,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading...');
        }

        return ListTile(
          leading: Icon(Icons.list),
          title: Text(
            list.title,
            style: TextStyle(
              color: snapshot.data == list.id ? Colors.blue : null,
            ),
          ),
          onTap: () {
            bloc.goToList(list.id);
            if (Scaffold.of(context).isDrawerOpen) {
              Navigator.of(context).pop();
            }
          },
        );
      },
    );
  }

  Widget buildNewListForm(AppBloc bloc) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(children: <Widget>[
        Icon(Icons.add),
        Expanded(
          child: TextField(
            onSubmitted: bloc.addList,
          ),
        ),
      ]),
    );
  }
}
