import 'dart:math' as math;
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:portfolio_uix/features/hangman/data/models/game_model.dart';
import 'package:portfolio_uix/features/hangman/data/models/record_model.dart';
import 'package:portfolio_uix/features/hangman/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';

class HangmanRepository {
  final SharedPreferences storage;
  final HangmanDatabase database;

  const HangmanRepository({
    required final this.storage,
    required final this.database,
  });

  /// Request random word from api
  /// Returns [getRandomWordFromCache] on any errors
  Future<String> getRandomWord() async {
    try {
      final http.Response response = await http.post(Uri.parse(Constants.url));

      final Map<String, dynamic> responseJson =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      final String word = responseJson['new']['word'].replaceAll('ё', 'е');

      print('Hidden word is: $word');

      return word.length > 12 ? await getRandomWord() : word;
    } catch (_) {
      return await getRandomWordFromCache();
    }
  }

  /// Load random word from previously played words
  /// If the cache is empty the default word will be returned
  Future<String> getRandomWordFromCache() async {
    final List<String>? words = storage.getStringList(Constants.cachedWords);

    if (words != null && words.isNotEmpty) {
      return words.elementAt(math.Random().nextInt(words.length));
    }

    return 'template';
  }

  /// Save currently played word to cache
  Future<void> saveWordToCache({required final String word}) async {
    try {
      final List<String> words =
          storage.getStringList(Constants.cachedWords) ?? [];

      words.add(word);
      storage.setStringList(Constants.cachedWords, words);
    } catch (error) {
      print('Failed to save with: $error');
    }
  }

  /// Save current [GameModel] state to local [storage]
  Future<void> saveCurrentState({required final GameModel gameModel}) async {
    try {
      await storage.setString(
        Constants.cachedState,
        convert.jsonEncode(gameModel.toJson()),
      );
    } catch (error) {
      print('Failed to save with: $error');
    }
  }

  /// Load last saved state from [storage]
  /// If [storage] is empty the new [GameModel.initial] will be returned
  Future<GameModel?> loadLastState() async {
    GameModel? gameModel;

    try {
      final String? state = storage.getString(Constants.cachedState);

      if (state != null) {
        print(convert.jsonDecode(state));
        gameModel = GameModel.fromJson(json: convert.jsonDecode(state));
      }
    } catch (error) {
      print('Failed to load with: $error');
    }

    return gameModel;
  }

  /// Save [wordsCount] to local [storage]
  Future<GameModel> saveRecordToCache({
    required final GameModel gameModel,
  }) async {
    print('Updating record of model with uuid: ${gameModel.uuid}');
    try {
      print('Updating');
      await database.updateRecord(newGameModel: gameModel);
      return gameModel;
    } catch (_) {
      print('Creating: $_');
      return await database.createRecord(gameModel: gameModel);
    }
  }

  Future<List<RecordModel>> loadRecords() async {
    try {
      return await database.readAllRecords();
    } catch (_) {
      print('Failed to load records: $_');
      return [];
    }
  }
}
