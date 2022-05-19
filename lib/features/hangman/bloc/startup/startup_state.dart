part of 'startup_bloc.dart';

abstract class StartupState extends Equatable {
  const StartupState();

  @override
  List<Object> get props => [];
}

class StartupInitial extends StartupState {
  const StartupInitial();
}

class StartupLoading extends StartupState {
  const StartupLoading();
}

class StartupSuccessful extends StartupState {
  const StartupSuccessful();
}

class StartupFailed extends StartupState {
  final String errorMessage;

  const StartupFailed({required final this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
