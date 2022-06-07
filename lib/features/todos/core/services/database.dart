import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portfolio_uix/features/todos/data/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

/// Table fields and types
class TableFields {
  static const List<String> values = [
    id,
    uuid,
    title,
    type,
    priority,
    createdAt,
    isCompleted,
  ];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String title = 'title';
  static const String type = 'type';
  static const String priority = 'priority';
  static const String createdAt = 'createdAt';
  static const String isCompleted = 'isCompleted';

  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
}

/// Database for todos. Singleton implementation
class TodoDatabase {
  /// Private constructor
  const TodoDatabase._();

  /// TodoDatabase [instance]
  static const TodoDatabase instance = TodoDatabase._();

  /// Database instance
  static Database? _database;

  /// Database file name
  static const String databaseName = 'todos.db';

  /// Database table name
  static const String tableName = 'todos';

  Future<Database> get database async {
    _database ??= await _initializeDatabase(databaseName);
    return _database!;
  }

  Future<Database> _initializeDatabase(final String fileName) async {
    final Directory path = await getApplicationDocumentsDirectory();
    final String filePath = join(path.path, fileName);

    return await openDatabase(filePath, version: 1, onCreate: _onCreateDb);
  }

  Future<void> _onCreateDb(final Database db, final int version) async {
    await db.execute(
      '''
        CREATE TABLE $tableName (
          ${TableFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
          ${TableFields.uuid} ${TableFields.textType},
          ${TableFields.title} ${TableFields.textType},
          ${TableFields.type} ${TableFields.intType},
          ${TableFields.priority} ${TableFields.intType},
          ${TableFields.createdAt} ${TableFields.textType},
          ${TableFields.isCompleted} ${TableFields.intType}
        )
      ''',
    );
  }

  /// Close [database]
  Future<void> close() async => (await instance.database).close();

  /// Clear existing [database]
  Future<void> erase() async {
    final db = await instance.database;
    db.execute('DROP TABLE IF EXISTS $tableName');
    _onCreateDb(db, 1);
  }

  /// Save [TodoModel] to [database]
  Future<TodoModel> createRecord({required final TodoModel todo}) async {
    final Database db = await instance.database;
    final int result = await db.insert(tableName, todo.toJson());

    return result == 0 ? throw Exception() : todo.copyWith(id: result);
  }

  /// Read all [TodoModel] from [database]
  Future<List<TodoModel>> readAllRecords() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> records = await db.query(
      tableName,
      orderBy: '${TableFields.createdAt} DESC',
    );

    return records.isNotEmpty
        ? records.map((json) => TodoModel.fromJson(json: json)).toList()
        : throw Exception('There are no records!');
  }

  /// Read [HabitModel] from [database] by its [id]
  Future<TodoModel> readRecordById({required final String id}) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> records = await db.query(
      tableName,
      columns: TableFields.values,
      where: '${TableFields.uuid} = ?',
      whereArgs: [id],
    );

    return records.isNotEmpty
        ? TodoModel.fromJson(json: records.first)
        : throw Exception();
  }

  /// Update [TodoModel] inside [database] by its [uuid]
  Future<int> updateRecord({required final TodoModel newTodo}) async {
    final Database db = await instance.database;
    final int changesCount = await db.update(
      tableName,
      newTodo.toJson(),
      where: '${TableFields.uuid} = ?',
      whereArgs: [newTodo.uuid],
    );

    return changesCount != 0 ? changesCount : throw Exception();
  }

  /// Delete [TodoModel] from [database] by its [id]
  Future<int> deleteRecord({required final String id}) async {
    final Database db = await instance.database;
    final int changesCount = await db.delete(
      tableName,
      where: '${TableFields.uuid} = ?',
      whereArgs: [id],
    );

    return changesCount != 0 ? changesCount : throw Exception();
  }
}
