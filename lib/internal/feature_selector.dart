import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio_uix/core/widgets/default_button.dart';
import 'package:portfolio_uix/features/hangman/presentation/pages/home.dart';

import '../features/hangman/bloc/startup/startup_bloc.dart';

class FeatureSelector extends StatelessWidget {
  const FeatureSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Selector'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HangmanHomePage(),
                ),
              ),
              text: 'Hangman Game',
              width: width * .8,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => StartupBloc(),
                    child: const HangmanHomePage(),
                  ),
                ),
              ),
              text: 'Rick & Morty Characters List',
              width: width * .8,
            ),
            const SizedBox(height: 30),
            DefaultButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) => StartupBloc(),
                    child: const HangmanHomePage(),
                  ),
                ),
              ),
              text: 'Hangman Game',
              width: width * .8,
            ),
          ],
        ),
      ),
    );
  }
}
