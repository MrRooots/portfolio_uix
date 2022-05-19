import 'package:get_it/get_it.dart';
import 'package:portfolio_uix/features/hangman/bloc/hangman/hangman_bloc.dart';
import 'package:portfolio_uix/features/hangman/data/repositories/hangman_repository.dart';
import 'package:portfolio_uix/features/hangman/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/hangman/bloc/scores_bloc/hangman_scores_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> initialize() async {
  sl.registerFactory(() => HangmanBloc(repository: sl()));

  sl.registerFactory(() => HangmanScoresBloc(repository: sl()));

  sl.registerLazySingleton(
    () => HangmanRepository(storage: sl(), database: sl()),
  );

  final SharedPreferences storage = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => storage);

  sl.registerLazySingleton(() => HangmanDatabase.instance);
}
