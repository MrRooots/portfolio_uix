part of 'hangman_scores_bloc.dart';

abstract class HangmanScoresState extends Equatable {
  const HangmanScoresState();

  @override
  List<Object> get props => [];
}

class HangmanScoresInitial extends HangmanScoresState {
  const HangmanScoresInitial();
}

class HangmanScoresLoading extends HangmanScoresState {
  const HangmanScoresLoading();
}

class HangmanScoresSuccessful extends HangmanScoresState {
  final List<RecordModel> records;

  const HangmanScoresSuccessful({required final this.records});
}

class HangmanScoresFailed extends HangmanScoresState {
  final String errorMessage;

  const HangmanScoresFailed({required final this.errorMessage});
}
