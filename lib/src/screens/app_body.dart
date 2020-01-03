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
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('No list found');
        }

        return ListProvider(
          snapshot.data,
          child: TaskListWidget(),
        );
      },
    );
  }
}
