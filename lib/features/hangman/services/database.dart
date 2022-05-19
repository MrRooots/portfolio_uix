import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portfolio_uix/features/hangman/data/models/game_model.dart';
import 'package:portfolio_uix/features/hangman/data/models/record_model.dart';
import 'package:sqflite/sqflite.dart';

/// Table fields and types
class TableFields {
  static const List<String> values = [id, uuid, wordsCount];

  static const String id = '_id';
  static const String uuid = 'uuid';
  static const String wordsCount = 'wordsCount';

  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
}

/// Database for hangman game records. Singleton implementation
class HangmanDatabase {
  /// Private constructor
  const HangmanDatabase._();

  /// HangmanDatabase [instance]
  static const HangmanDatabase instance = HangmanDatabase._();

  /// Database instance
  static Database? _database;

  /// Database file name
  static const String databaseName = 'hangmanRecords.db';

  /// Database table name
  static const String tableName = 'records';

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
          ${TableFields.wordsCount} ${TableFields.intType}
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

  /// Save [GameModel] to [database]
  Future<GameModel> createRecord({required final GameModel gameModel}) async {
    final Database db = await instance.database;
    final int result = await db.insert(tableName, gameModel.toDatabaseJson());
    print('Record created with _id = $result, uuid = ${gameModel.uuid}');
    return result == 0 ? throw Exception() : gameModel.copyWith(id: result);
  }

  /// Read all [GameModel] from [database]
  Future<List<RecordModel>> readAllRecords() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> records = await db.query(
      tableName,
      columns: [TableFields.wordsCount],
      orderBy: '${TableFields.wordsCount} DESC',
      distinct: true,
    );
    print(records);
    if (records.isNotEmpty) {
      return records.map((json) => RecordModel.fromJson(json: json)).toList();
    }

    throw Exception('There are no records!');
  }

  /// Read [HabitModel] from [database] by its [id]
  Future<RecordModel> readRecordById({required final String id}) async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> records = await db.query(
      tableName,
      columns: TableFields.values,
      where: '${TableFields.uuid} = ?',
      whereArgs: [id],
    );

    return records.isNotEmpty
        ? RecordModel.fromJson(json: records.first)
        : throw Exception();
  }

  /// Update [GameModel] inside [database] by its [uuid]
  Future<int> updateRecord({required final GameModel newGameModel}) async {
    final Database db = await instance.database;
    print(newGameModel.toDatabaseJson());
    final int changesCount = await db.update(
      tableName,
      newGameModel.toDatabaseJson(),
      where: '${TableFields.uuid} = ?',
      whereArgs: [newGameModel.uuid],
    );

    return changesCount != 0 ? changesCount : throw Exception();
  }

  /// Delete [GameModel] from [database] by its [id]
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
