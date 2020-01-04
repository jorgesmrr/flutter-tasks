import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_bloc.dart';
import 'package:tasks/src/blocs/app_provider.dart';
import 'package:tasks/src/screens/app_body.dart';
import 'package:tasks/src/screens/app_drawer.dart';

class TasksApp extends StatelessWidget {
  Widget build(context) {
    AppBloc bloc = AppProvider.of(context);

    return StreamBuilder(
      stream: bloc.allowToAddTasks,
      builder: (context, snapshot) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: Text('My Tasks')),
            floatingActionButton: (snapshot.data ?? false)
                ? null
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: bloc.allowAddTasks,
                  ),
            body: AppBody(),
            drawer: AppDrawer(),
          ),
        );
      },
    );
  }
}
