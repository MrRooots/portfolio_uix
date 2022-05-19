import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:portfolio_uix/core/palette/palette.dart';

import 'package:portfolio_uix/features/hangman/bloc/hangman/hangman_bloc.dart';
import 'package:portfolio_uix/features/hangman/data/models/game_model.dart';
import 'package:portfolio_uix/features/hangman/presentation/widgets/notification.dart';

import '../widgets/keyboard.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BlocConsumer<HangmanBloc, HangmanState>(
            listener: (context, state) async {
              if (state is HangmanNotification) {
                await showDialog(
                  context: context,
                  builder: (_) =>
                      NotificationDialog(gameModel: state.gameModel),
                );
                BlocProvider.of<HangmanBloc>(context).add(
                    HangmanInitialize(wordsCount: state.gameModel.wordsCount));
              }
            },
            buildWhen: (state, previous) =>
                state is! HangmanNotification &&
                previous is! HangmanNotification &&
                state != previous,
            builder: (context, state) {
              if (state is HangmanLoaded) {
                return GameLoadedBody(gameModel: state.gameModel);
              } else if (state is HangmanLoading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Loading word', style: TextStyle(fontSize: 28.0)),
                      SizedBox(height: 15),
                      CircularProgressIndicator(color: Palette.orange),
                    ],
                  ),
                );
              } else if (state is HangmanFailed) {
                return const Center(child: Text('Failed to load words'));
              } else {
                return const Center(child: Text('Undefined state'));
              }
            },
          ),
        ),
      ),
    );
  }
}

class GameLoadedBody extends StatelessWidget {
  final GameModel gameModel;

  const GameLoadedBody({Key? key, required final this.gameModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guessed in a row: ${gameModel.wordsCount}'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset('assets/icons/back.svg'),
        ),
        actions: [
          IconButton(
            onPressed: () => BlocProvider.of<HangmanBloc>(context).add(
              HangmanHintPressed(gameModel: gameModel),
            ),
            icon: Icon(
              Icons.lightbulb,
              color: gameModel.hintsCount > 0 ? Palette.red : Palette.grey,
            ),
          ),
          IconButton(
            onPressed: () => BlocProvider.of<HangmanBloc>(context).add(
              HangmanResetButtonPressed(),
            ),
            icon: Icon(
              Icons.restore,
              color: gameModel.hintsCount > 0 ? Palette.red : Palette.grey,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/img/hangman/${5 - gameModel.lives}.png',
            width: MediaQuery.of(context).size.width * .7,
            color: Palette.black,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: gameModel.hiddenWord
                .map((e) => Text(
                      e,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 50.0,
                      ),
                    ))
                .toList(),
          ),
          const Spacer(),
          GameKeyboard(gameModel: gameModel),
        ],
      ),
    );
  }
}
