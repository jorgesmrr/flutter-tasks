import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tasks/src/blocs/list_bloc.dart';

class ListProvider extends InheritedWidget {
  final ListBloc _bloc;

  ListProvider(ValueStream<int> listId, {Key key, Widget child})
      : _bloc = ListBloc(listId),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static ListBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ListProvider>()._bloc;
  }
}
