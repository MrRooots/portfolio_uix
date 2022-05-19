import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:portfolio_uix/features/hangman/data/models/record_model.dart';
import 'package:portfolio_uix/features/hangman/data/repositories/hangman_repository.dart';

part 'hangman_scores_event.dart';
part 'hangman_scores_state.dart';

class HangmanScoresBloc extends Bloc<HangmanScoresEvent, HangmanScoresState> {
  final HangmanRepository repository;
  HangmanScoresBloc({required final this.repository})
      : super(const HangmanScoresInitial()) {
    on<HangmanScoresFetch>(_onHangmanScoresFetch);
  }

  Future<void> _onHangmanScoresFetch(
    HangmanScoresFetch event,
    Emitter<HangmanScoresState> emit,
  ) async {
    emit(const HangmanScoresLoading());

    try {
      final List<RecordModel> records = await repository.loadRecords();
      emit(HangmanScoresSuccessful(records: records));
    } catch (error) {
      emit(HangmanScoresFailed(errorMessage: error.toString()));
    }
  }
}
