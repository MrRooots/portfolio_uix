import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/gestures.dart';
import 'package:portfolio_uix/features/hangman/data/models/game_model.dart';
import 'package:portfolio_uix/features/hangman/data/repositories/hangman_repository.dart';
import 'package:portfolio_uix/features/hangman/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'hangman_event.dart';
part 'hangman_state.dart';

/// !Important
/// Todo: cleanup\rework state management and model state saving
/// Todo: add records table

class HangmanBloc extends Bloc<HangmanEvent, HangmanState> {
  final HangmanRepository repository;
  HangmanBloc({required final this.repository})
      : super(const HangmanInitial()) {
    on<HangmanInitialize>(_onHangmanInitialize);
    on<HangmanCharacterPressed>(_onHangmanWordButtonPressed);
    on<HangmanHintPressed>(_onHangmanHintPressed);
    on<HangmanResetButtonPressed>(_onHangmanResetButtonPressed);
  }

  Future<void> _onHangmanInitialize(
    HangmanInitialize event,
    Emitter<HangmanState> emit,
  ) async {
    emit(const HangmanLoading());

    final GameModel? loadedModel = await repository.loadLastState();
    GameModel gameModel;

    if (_isModelStateValid(loadedModel)) {
      gameModel = GameModel.initial(
        id: loadedModel?.lives != 0 ? loadedModel?.id : null,
        uuid: loadedModel?.lives != 0 ? loadedModel?.uuid : null,
        word: await repository.getRandomWord(),
        wordsCount: event.wordsCount,
      );
    } else {
      gameModel = loadedModel!;
    }

    await repository.saveCurrentState(gameModel: gameModel);

    emit(HangmanLoaded(gameModel: gameModel));
  }

  Future<void> _onHangmanWordButtonPressed(
    HangmanCharacterPressed event,
    Emitter<HangmanState> emit,
  ) async {
    final GameModel _m = event.gameModel;

    // Todo: cleanup states
    switch (_m.checkCharacter(character: event.character)) {
      case 0:
        final GameModel _nm = _m.copyWith(lives: _m.lives - 1);
        emit(HangmanLoaded(gameModel: _nm));
        if (_m.lives == 0) {
          final GameModel _nm = _m.copyWith(wordsCount: 0);
          emit(HangmanNotification(gameModel: _nm));
        } else {
          repository.saveCurrentState(gameModel: _nm);
        }

        break;
      case 1:
        repository.saveCurrentState(gameModel: _m);
        emit(HangmanLoaded(gameModel: _m));
        break;
      case 2:
        GameModel _nm = _m.copyWith(wordsCount: _m.wordsCount + 1);
        _nm = await repository.saveRecordToCache(gameModel: _nm);
        await repository.saveCurrentState(gameModel: _nm);
        emit(HangmanLoaded(gameModel: _nm));
        emit(HangmanNotification(gameModel: _nm));
        break;
    }
  }

  Future<void> _onHangmanHintPressed(
    HangmanHintPressed event,
    Emitter<HangmanState> emit,
  ) async {
    final GameModel _m = event.gameModel;

    if (_m.hintsCount > 0) {
      _m.checkCharacter(character: _m.hintCharacter);
      emit(HangmanLoaded(
        gameModel: _m.copyWith(hintsCount: _m.hintsCount - 1),
      ));
      if (_m.isWordGuessed) {
        emit(HangmanNotification(
          gameModel: _m.copyWith(wordsCount: _m.wordsCount + 1),
        ));
      }
    }
  }

  /// Check if [gameModel] is not null,
  /// has [GameModel.lives] or [GameModel.isWordGuessed]
  bool _isModelStateValid(final GameModel? gameModel) =>
      gameModel == null || gameModel.lives == 0 || gameModel.isWordGuessed;

  Future<void> _onHangmanResetButtonPressed(
    HangmanResetButtonPressed event,
    Emitter<HangmanState> emit,
  ) async {
    await HangmanDatabase.instance.erase();
    (await SharedPreferences.getInstance()).clear();
    emit(HangmanLoaded(
        gameModel: GameModel.initial(word: await repository.getRandomWord())));
  }
}
