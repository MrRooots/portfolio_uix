import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'startup_event.dart';
part 'startup_state.dart';

class StartupBloc extends Bloc<StartupEvent, StartupState> {
  StartupBloc() : super(const StartupInitial()) {
    on<StartupStarted>(_onStartupStarted);
  }

  Future<void> _onStartupStarted(
    StartupStarted event,
    Emitter<StartupState> emit,
  ) async {
    emit(const StartupLoading());

    await Future.delayed(const Duration(seconds: 2));

    // emit(const StartupSuccessful());
    emit(const StartupFailed(
        errorMessage: 'Failed to load some important data'));
  }
}
