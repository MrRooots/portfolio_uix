import 'package:portfolio_uix/core/data/todos/data.dart';
import 'package:portfolio_uix/features/todos/data/models/todo_model.dart';
import 'package:portfolio_uix/features/todos/domain/entities/todo_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/database.dart';

abstract class TodoLocalDataSource {
  /// Save given [todo] to local [TodoDatabase]
  Future<void> saveToCache({required final TodoModel todo});

  /// Load all [TodoEntity] from local [TodoDatabase]
  Future<List<TodoEntity>> loadAllTodos();

  /// Load [TodoEntity] with given filters from local [TodoDatabase]
  Future<List<TodoEntity>> loadTodosWhere({
    final String? title,
    final TodoType? type,
    final TodoPriority? priority,
    final bool? isCompleted,
  });
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  /// Local [storage] instance
  final SharedPreferences storage;

  /// Local [database] instance
  final TodoDatabase database;

  const TodoLocalDataSourceImpl({
    required final this.storage,
    required final this.database,
  });

  @override
  Future<List<TodoEntity>> loadAllTodos() async {
    final List<TodoEntity> todos = [];

    return todos;
  }

  @override
  Future<List<TodoEntity>> loadTodosWhere(
      {String? title,
      TodoType? type,
      TodoPriority? priority,
      bool? isCompleted}) async {
    final List<TodoEntity> todos = [];

    return todos;
  }

  @override
  Future<void> saveToCache({required TodoModel todo}) async {}
}
