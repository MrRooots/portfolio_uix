part of 'hangman_scores_bloc.dart';

abstract class HangmanScoresEvent extends Equatable {
  const HangmanScoresEvent();

  @override
  List<Object> get props => [];
}

class HangmanScoresFetch extends HangmanScoresEvent {}
