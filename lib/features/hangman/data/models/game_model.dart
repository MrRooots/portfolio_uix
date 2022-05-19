import 'dart:math';

import 'package:equatable/equatable.dart';

import 'package:portfolio_uix/core/utils/utils.dart';
import 'package:uuid/uuid.dart';

class GameModel extends Equatable {
  /// [HangmanDatabase] required id
  final int? id;

  /// Uuid of the current game
  final String uuid;

  /// Current [word]
  final String word;

  /// Hidden [word]
  final List<String> hiddenWord;

  /// Count of [lives]
  final int lives;

  /// Count of guessed words
  final int wordsCount;

  /// Count of available hints
  final int hintsCount;

  /// Available letters for hint
  final List<String> hintLetters;

  final List<String> usedCharacters;

  /// Constructor
  const GameModel({
    final this.id,
    required final this.uuid,
    required final this.word,
    required final this.hiddenWord,
    required final this.lives,
    required final this.wordsCount,
    required final this.hintsCount,
    required final this.hintLetters,
    required final this.usedCharacters,
  });

  /// Create empty [GameModel]
  factory GameModel.initial({
    required final String word,
    final int wordsCount = 0,
    final String? uuid,
    final int? id,
  }) =>
      GameModel(
        id: id,
        uuid: uuid ?? const Uuid().v4(),
        word: word,
        hiddenWord: Utils.stringToList(word, toUnderscores: true),
        lives: 5,
        wordsCount: wordsCount,
        hintsCount: 5,
        hintLetters: Utils.stringToList(word),
        usedCharacters: [],
      );

  GameModel copyWith({
    final int? id,
    final String? uuid,
    final String? word,
    final List<String>? hiddenWord,
    final int? lives,
    final int? wordsCount,
    final int? hintsCount,
    final List<String>? hintLetters,
    final List<String>? usedCharacters,
  }) {
    return GameModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      word: word ?? this.word,
      hiddenWord: hiddenWord ?? this.hiddenWord,
      lives: lives ?? this.lives,
      wordsCount: wordsCount ?? this.wordsCount,
      hintsCount: hintsCount ?? this.hintsCount,
      hintLetters: hintLetters ?? this.hintLetters,
      usedCharacters: usedCharacters ?? this.usedCharacters,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uuid': uuid,
        'word': word,
        'hiddenWord': hiddenWord,
        'lives': lives,
        'wordsCount': wordsCount,
        'hintsCount': hintsCount,
        'hintLetters': hintLetters,
        'usedCharacters': usedCharacters
      };

  Map<String, dynamic> toDatabaseJson() => {
        '_id': id,
        'uuid': uuid,
        'wordsCount': wordsCount,
      };

  factory GameModel.fromJson({required final Map<String, dynamic> json}) =>
      GameModel(
        id: json['id'],
        uuid: json['uuid'],
        word: json['word'],
        hiddenWord:
            (json['hiddenWord'] as List).map((e) => e.toString()).toList(),
        lives: json['lives'],
        wordsCount: json['wordsCount'],
        hintsCount: json['hintsCount'],
        hintLetters:
            (json['hintLetters'] as List).map((e) => e.toString()).toList(),
        usedCharacters:
            (json['usedCharacters'] as List).map((e) => e.toString()).toList(),
      );

  /// Get random hint letter for current [word] and remove it from [hintLetters]
  String get hintCharacter =>
      hintLetters.removeAt(Random().nextInt(hintLetters.length));

  /// Check if [word] is completely guessed
  bool get isWordGuessed => !hiddenWord.contains('_');

  /// Check if given [character] contains in [word]
  ///
  /// Returns:
  /// - 0 if [word] does not contains given [character]
  /// - 1 if [word] contains given [character] and unknown letters remained
  /// - 2 if [word] guessed completely
  int checkCharacter({required final String character}) {
    usedCharacters.add(character);
    if (word.contains(character)) {
      for (var i = 0; i < word.length; i++) {
        if (word[i] == character) {
          hiddenWord[i] = character;
        }
      }

      return hiddenWord.contains('_') ? 1 : 2;
    } else {
      return 0;
    }
  }

  @override
  List<Object?> get props => [
        id,
        uuid,
        word,
        hiddenWord,
        lives,
        wordsCount,
        hintsCount,
        hintLetters,
      ];
}
