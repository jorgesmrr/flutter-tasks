import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_bloc.dart';
import 'package:tasks/src/blocs/app_provider.dart';
import 'package:tasks/src/models/tasks_list.dart';

class AppDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    AppBloc bloc = AppProvider.of(context);

    return Drawer(
      child: StreamBuilder(
        stream: bloc.lists,
        builder: (context, AsyncSnapshot<List<TasksList>> snapshot) {
          return snapshot.hasData
              ? buildList(context, bloc, snapshot.data)
              : Text('Loading lists...');
        },
      ),
    );
  }

  Widget buildList(BuildContext context, AppBloc bloc, List<TasksList> lists) {
    return ListView.separated(
      itemCount: lists.length + 1,
      itemBuilder: (context, index) {
        if (index == lists.length) {
          return buildNewTasksListItem(context, bloc);
        }

        return buildTasksListItem(bloc, lists[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildTasksListItem(AppBloc bloc, TasksList list) {
    return StreamBuilder(
      stream: bloc.activeList,
      builder: (context, snapshot) {
        return ListTile(
          leading: Icon(Icons.list),
          title: Text(
            list.title,
            style: TextStyle(
              color: snapshot.hasData && snapshot.data == list.id
                  ? Colors.blue
                  : null,
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

  Widget buildNewTasksListItem(BuildContext context, AppBloc bloc) {
    return ListTile(
      leading: Icon(Icons.add),
      title: Text('Create new list...'),
      onTap: () => showNewListDialog(context, bloc),
    );
  }

  Future showNewListDialog(BuildContext context, AppBloc bloc) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        final textController = new TextEditingController();

        return AlertDialog(
          title: Text('Create new list'),
          content: TextField(
            decoration: InputDecoration(labelText: 'Name'),
            controller: textController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text('Create'),
              onPressed: () {
                bloc.addList(textController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
