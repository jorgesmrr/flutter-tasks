import 'package:flutter/material.dart';
import 'package:tasks/src/blocs/app_provider.dart';
import 'package:tasks/src/screens/app_body.dart';
import 'package:tasks/src/screens/app_drawer.dart';

class TasksApp extends StatelessWidget {
  Widget build(context) {
    return AppProvider(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(title: Text('My Tasks')),
          body: AppBody(),
          drawer: AppDrawer(),
        ),
      ),
    );
  }
}
