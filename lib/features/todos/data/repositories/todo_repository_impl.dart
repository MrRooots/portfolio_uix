import 'package:portfolio_uix/core/data/todos/data.dart';
import 'package:portfolio_uix/features/todos/core/failures/exception.dart';
import 'package:portfolio_uix/features/todos/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:portfolio_uix/features/todos/data/datasources/local_data_source.dart';
import 'package:portfolio_uix/features/todos/domain/entities/todo_entity.dart';
import 'package:portfolio_uix/features/todos/data/models/todo_model.dart';
import 'package:portfolio_uix/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  const TodoRepositoryImpl({required final this.localDataSource});

  @override
  Future<Either<TodoEntity, Failure>> createTodo({
    required TodoModel todo,
  }) async {
    try {
      return left(await localDataSource.createTodo(todo: todo));
    } on CacheException catch (error) {
      return right(CacheFailure(error.error));
    } catch (error) {
      return right(UndefinedFailure(error.toString()));
    }
  }

  @override
  Future<Either<List<TodoEntity>, Failure>> readAllTodos() async {
    // TODO: implement readAllTodos
    throw UnimplementedError();
  }

  @override
  Future<Either<List<TodoEntity>, Failure>> readTodosWhere({
    String? id,
    String? title,
    TodoType? type,
    TodoPriority? priority,
    bool? isCompleted,
  }) async {
    // TODO: implement readTodosWhere
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoEntity, Failure>> deleteTodo({required String id}) async {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<TodoEntity, Failure>> updateTodo({
    required TodoModel todo,
  }) async {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
