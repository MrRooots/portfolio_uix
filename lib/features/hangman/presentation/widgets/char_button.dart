import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_uix/features/hangman/bloc/hangman/hangman_bloc.dart';
import 'package:portfolio_uix/features/hangman/data/models/game_model.dart';

import '../../../../core/data/alphabet.dart';
import 'word_button.dart';

class CharacterButton extends StatelessWidget {
  final int index;
  final GameModel gameModel;

  const CharacterButton({
    Key? key,
    required final this.index,
    required final this.gameModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String character = Alphabet.characters[index].toUpperCase();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 6.0),
      child: Center(
        child: WordButton(
          character: character,
          onPressed: gameModel.usedCharacters.contains(character.toLowerCase())
              ? null
              : () => BlocProvider.of<HangmanBloc>(context).add(
                    HangmanCharacterPressed(
                      character: character.toLowerCase(),
                      gameModel: gameModel,
                    ),
                  ),
        ),
      ),
    );
  }
}
