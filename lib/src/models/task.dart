class Task {
  int id;
  int listId;
  String title;
  bool done;

  Task(this.listId, this.title, {this.done = false});

  Task.fromMap(Map<String, dynamic> record) {
    id = record['id'];
    listId = record['list_id'];
    title = record['title'];
    done = record['done'] != null ? record['done'] == 1 : false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'list_id': listId,
      'done': done ? 1 : 0,
    };
  }
}
