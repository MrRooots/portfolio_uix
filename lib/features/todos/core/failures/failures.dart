import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

/// No cached values was found
class CacheFailure extends Failure {
  final String error;

  CacheFailure(this.error);

  @override
  List<Object?> get props => [error];
}

/// Implements all different exceptions
class UndefinedFailure extends Failure {
  final String error;

  UndefinedFailure(this.error);

  @override
  List<Object?> get props => [error];
}
