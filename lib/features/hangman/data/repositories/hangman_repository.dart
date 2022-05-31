import 'dart:math' as math;
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:portfolio_uix/core/data/hangman/data.dart';
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
      final http.Response response = await http
          .post(Uri.parse(Constants.url))
          .timeout(const Duration(seconds: 5));

      final Map<String, dynamic> responseJson =
          convert.jsonDecode(convert.utf8.decode(response.bodyBytes));

      final String word = responseJson['new']['word'].replaceAll('ё', 'е');

      print('Hidden word is: $word');

      return word.length > 12 ? await getRandomWord() : word;
    } catch (_) {
      print('Failed with: $_');
      return await getRandomWordFromCache();
    }
  }

  /// Load random word from the list of previously played words
  /// If [storage] is empty the word from [HangmanWords] will be returned
  Future<String> getRandomWordFromCache() async {
    try {
      final List<String>? words = storage.getStringList(Constants.cachedWords);

      if (words != null && words.isNotEmpty) {
        return words.elementAt(math.Random().nextInt(words.length));
      } else {
        await storage.setStringList(Constants.cachedWords, HangmanWords.words);
        return HangmanWords.words.elementAt(
          math.Random().nextInt(HangmanWords.words.length),
        );
      }
    } catch (error) {
      print('[getRandomWordFromCache]: Failed to read: $error');
      return 'пивоварня';
    }
  }

  /// Save currently played word to cache
  Future<void> saveWordToCache({required final String word}) async {
    try {
      final List<String> words =
          storage.getStringList(Constants.cachedWords) ?? [];

      words.add(word);
      storage.setStringList(Constants.cachedWords, words);
    } catch (error) {
      print('[saveWordToCache]: Failed to save: $error');
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
      print('[saveCurrentState]: Failed to save: $error');
    }
  }

  /// Load last saved state from [storage]
  /// If [storage] is empty the new [GameModel.initial] will be returned
  Future<GameModel?> loadLastState() async {
    GameModel? gameModel;

    try {
      final String? state = storage.getString(Constants.cachedState);

      if (state != null) {
        gameModel = GameModel.fromJson(json: convert.jsonDecode(state));
      }
    } catch (error) {
      print('[loadLastState]: Failed to load: $error');
    }

    return gameModel;
  }

  /// Save [wordsCount] to local [storage]
  Future<GameModel> saveRecordToCache({
    required final GameModel gameModel,
  }) async {
    try {
      await database.updateRecord(newGameModel: gameModel);
      return gameModel;
    } catch (_) {
      return await database.createRecord(gameModel: gameModel);
    }
  }

  Future<List<RecordModel>> loadRecords() async {
    try {
      return await database.readAllRecords();
    } catch (error) {
      print('[loadRecords]: Failed to load records: $error');
      return [];
    }
  }
}
