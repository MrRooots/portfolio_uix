import 'package:dartz/dartz.dart';
import 'package:portfolio_uix/features/todos/core/failures/failures.dart';
import 'package:portfolio_uix/features/todos/core/services/database.dart';
import 'package:portfolio_uix/features/todos/data/models/todo_model.dart';
import 'package:portfolio_uix/features/todos/domain/entities/todo_entity.dart';

import '../../../../core/data/todos/data.dart';

abstract class TodoRepository {
  /// Create new [TodoModel] todo inside [TodoDatabase]
  ///
  /// Throws [CacheFailure] on any [TodoDatabase] errors
  Future<Either<TodoEntity, Failure>> createTodo({
    required final TodoModel todo,
  });

  /// Read all [TodoModel] todos from [TodoDatabase]
  ///
  /// Throws [CacheFailure] on any [TodoDatabase] errors
  Future<Either<List<TodoEntity>, Failure>> readAllTodos();

  /// Read [TodoModel] todo from [TodoDatabase] by given [id]
  ///
  /// Throws [CacheFailure] on any [TodoDatabase] errors
  Future<Either<List<TodoEntity>, Failure>> readTodosWhere({
    final String? id,
    final String? title,
    final TodoType? type,
    final TodoPriority? priority,
    final bool? isCompleted,
  });

  /// Update [TodoModel] todo inside [TodoDatabase] by given [todo]
  ///
  /// Throws [CacheFailure] on any [TodoDatabase] errors
  Future<Either<TodoEntity, Failure>> updateTodo({
    required final TodoModel todo,
  });

  /// Delete [TodoModel] todo from [TodoDatabase] by given [id]
  ///
  /// Throws [CacheFailure] on any [TodoDatabase] errors
  Future<Either<TodoEntity, Failure>> deleteTodo({required final String id});
}
