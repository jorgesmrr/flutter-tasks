import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_bloc.dart';

class AppProvider extends InheritedWidget {
  final AppBloc _bloc;

  AppProvider({Key key, Widget child})
      : _bloc = AppBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AppBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppProvider>()._bloc;
  }
}
