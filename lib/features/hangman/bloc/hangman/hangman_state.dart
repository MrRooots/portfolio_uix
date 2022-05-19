part of 'hangman_bloc.dart';

abstract class HangmanState extends Equatable {
  const HangmanState();

  @override
  List<Object> get props => [];
}

class HangmanInitial extends HangmanState {
  const HangmanInitial();
}

class HangmanLoaded extends HangmanState {
  final GameModel gameModel;

  const HangmanLoaded({required final this.gameModel});

  @override
  List<Object> get props => [gameModel, identityHashCode(this)];
}

class HangmanLoading extends HangmanState {
  const HangmanLoading();
}

class HangmanFailed extends HangmanState {
  const HangmanFailed();
}

class HangmanNotification extends HangmanState {
  final GameModel gameModel;

  const HangmanNotification({required final this.gameModel});

  @override
  List<Object> get props => [gameModel];
}
