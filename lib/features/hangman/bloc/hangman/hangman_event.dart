part of 'hangman_bloc.dart';

abstract class HangmanEvent extends Equatable {
  const HangmanEvent();

  @override
  List<Object> get props => [];
}

/// Initialize the game
class HangmanInitialize extends HangmanEvent {
  final int wordsCount;
  const HangmanInitialize({required final this.wordsCount});
}

/// The character button pressed
class HangmanCharacterPressed extends HangmanEvent {
  final String character;
  final GameModel gameModel;

  const HangmanCharacterPressed({
    required final this.character,
    required final this.gameModel,
  });
}

/// The hint button pressed
class HangmanHintPressed extends HangmanEvent {
  final GameModel gameModel;

  const HangmanHintPressed({required final this.gameModel});
}

class HangmanResetButtonPressed extends HangmanEvent {}
