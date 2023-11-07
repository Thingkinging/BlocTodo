import 'dart:async';

import 'package:bloc_todo/data/todo.dart';
import 'package:bloc_todo/data/todo_db.dart';

class TodoBloc {
  TodoDb? db;
  List<Todo>? todoList;

  TodoBloc() {
    db = TodoDb();
    getTodos();

    _todoStreamController.stream.listen(returnTodos);
    _todoInsertController.stream.listen(_addTodo);
    _todoUpdateController.stream.listen(_updateTodo);
    _todoDeleteController.stream.listen(_deleteTodo);
  }

  final _todoStreamController = StreamController<List<Todo>>.broadcast();
  final _todoInsertController = StreamController<Todo>.broadcast();
  final _todoUpdateController = StreamController<Todo>.broadcast();
  final _todoDeleteController = StreamController<Todo>.broadcast();

  Stream<List<Todo>> get todos => _todoStreamController.stream;
  StreamSink<List<Todo>> get todosSink => _todoStreamController.sink;
  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;
  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;
  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  Future getTodos() async {
    List<Todo> todos = await db!.getTodos();
    todoList = todos;
    todosSink.add(todos);
  }

  List<Todo> returnTodos(todos) {
    return todos;
  }

  void _deleteTodo(Todo todo) {
    db!.deleteTodo(todo).then((result) {
      getTodos();
    });
  }

  void _updateTodo(Todo todo) {
    db!.updateTodo(todo).then((result) {
      getTodos();
    });
  }

  void _addTodo(Todo todo) {
    db!.insertTodo(todo).then((result) {
      getTodos();
    });
  }

  void dispose() {
    _todoStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }
}
