import 'package:portfolio_uix/core/data/todos/data.dart';
import 'package:portfolio_uix/features/todos/data/models/todo_model.dart';
import 'package:portfolio_uix/features/todos/domain/entities/todo_entity.dart';
import 'package:portfolio_uix/features/todos/domain/usecases/create_todo.dart';
import 'package:portfolio_uix/features/todos/domain/usecases/delete_todo.dart';
import 'package:portfolio_uix/features/todos/domain/usecases/read_all_todos.dart';
import 'package:portfolio_uix/features/todos/domain/usecases/read_todo_by_id.dart';
import 'package:portfolio_uix/features/todos/domain/usecases/update_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/services/database.dart';

abstract class TodoLocalDataSource {
  /// Save given [todo] to local [TodoDatabase]
  Future<TodoEntity> createTodo({required final TodoModel todo});

  /// Load all [TodoEntity] from local [TodoDatabase]
  Future<List<TodoEntity>> readAllTodos();

  /// Load [TodoEntity] with given filters from local [TodoDatabase]
  Future<List<TodoEntity>> readTodosWhere({
    final String? id,
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

  final CreateTodoUseCase createTodoUseCase;
  final ReadAllTodosUseCase readAllTodosUseCase;
  final ReadTodosWhereUseCase readTodosWhereUseCase;
  final UpdateTodoUseCase updateTodoUseCase;
  final DeleteTodoUseCase deleteTodo;

  const TodoLocalDataSourceImpl({
    required final this.storage,
    required final this.database,
    required final this.createTodoUseCase,
    required final this.readAllTodosUseCase,
    required final this.readTodosWhereUseCase,
    required final this.updateTodoUseCase,
    required final this.deleteTodo,
  });

  @override
  Future<TodoEntity> createTodo({required TodoModel todo}) async {}

  @override
  Future<List<TodoEntity>> readAllTodos() async {
    final List<TodoEntity> todos = [];

    return todos;
  }

  @override
  Future<List<TodoEntity>> readTodosWhere({
    final String? id,
    final String? title,
    final TodoType? type,
    final TodoPriority? priority,
    final bool? isCompleted,
  }) async {
    final List<TodoEntity> todos = [];

    return todos;
  }
}
