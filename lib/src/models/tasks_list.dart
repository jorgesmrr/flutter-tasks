class TasksList {
  int id;
  String title;

  TasksList(this.title, {this.id});

  TasksList.fromMap(Map<String, dynamic> record) {
    id = record['id'];
    title = record['title'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }
}
