import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:portfolio_uix/core/palette/palette.dart';

import '../../bloc/scores_bloc/hangman_scores_bloc.dart';
import '../widgets/record_tile.dart';

class HangmanHighScoresPage extends StatelessWidget {
  const HangmanHighScoresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman High Scores'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset('assets/icons/back.svg'),
        ),
      ),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HangmanScoresBloc, HangmanScoresState>(
      builder: (context, state) {
        if (state is HangmanScoresSuccessful) {
          return ListView.builder(
            itemCount: state.records.length,
            itemBuilder: (final BuildContext context, final int i) {
              return RecordTile(record: state.records[i].wordsCount!, rank: i);
            },
          );
        } else if (state is HangmanScoresFailed) {
          return Center(child: Text(state.errorMessage));
        } else if (state is HangmanScoresLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Palette.orange),
          );
        } else {
          return const Center(child: Text('Undefined state'));
        }
      },
    );
  }
}
