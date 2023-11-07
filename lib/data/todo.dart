class Todo {
  int? id;
  String name;
  String decription;
  String completeBy;
  int priority;

  Todo(
    this.name,
    this.decription,
    this.completeBy,
    this.priority,
  );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': decription,
      'completeBy': completeBy,
      'priority': priority,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
        map['name'], map['decription'], map['completeBy'], map['priority']);
  }
}
