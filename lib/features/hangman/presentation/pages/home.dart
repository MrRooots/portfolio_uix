import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_uix/service_locator.dart';

import '../../../../core/widgets/default_button.dart';
import '../../bloc/hangman/hangman_bloc.dart';
import '../../bloc/scores_bloc/hangman_scores_bloc.dart';
import 'game.dart';
import 'scores.dart';

class HangmanHomePage extends StatelessWidget {
  const HangmanHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman Game'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset('assets/icons/back.svg'),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/img/hangman/gallow.png'),
          Column(
            children: [
              DefaultButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => sl<HangmanBloc>()
                      ..add(const HangmanInitialize(wordsCount: 0)),
                    child: const GamePage(),
                  ),
                )),
                width: width * .8,
                text: 'Start',
              ),
              const SizedBox(height: 25),
              DefaultButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        sl<HangmanScoresBloc>()..add(HangmanScoresFetch()),
                    child: const HangmanHighScoresPage(),
                  ),
                )),
                width: width * .8,
                text: 'High Scores',
              ),
            ],
          )
        ],
      ),
    );
  }
}
