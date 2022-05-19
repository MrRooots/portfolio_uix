import 'package:flutter/material.dart';

import 'package:portfolio_uix/core/palette/palette.dart';

class HangmanSplashPage extends StatelessWidget {
  final String? errorMessage;

  const HangmanSplashPage({Key? key, final this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Image.asset(
              'assets/img/hangman/gallow.png',
              height: height * .5,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 100, minHeight: 100),
            child: errorMessage == null
                ? const Center(
                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: CircularProgressIndicator(
                        color: Palette.orange,
                        strokeWidth: 3,
                      ),
                    ),
                  )
                : Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Palette.red),
                  ),
          ),
        ],
      ),
    );
  }
}
