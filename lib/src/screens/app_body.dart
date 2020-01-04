import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_bloc.dart';
import 'package:tasks/src/blocs/app_provider.dart';
import 'package:tasks/src/blocs/list_provider.dart';
import 'package:tasks/src/screens/task_list.dart';

class AppBody extends StatelessWidget {
  Widget build(context) {
    final AppBloc bloc = AppProvider.of(context);

    return StreamBuilder(
      stream: bloc.activeList,
      builder: (context, AsyncSnapshot<int> snapshot) {
        if (!snapshot.hasData) {
          return Text('Select a list from the drawer menu');
        }

        return ListProvider(
          bloc.activeList,
          child: TasksListWidget(),
        );
      },
    );
  }
}
