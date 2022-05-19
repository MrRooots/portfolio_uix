import 'package:flutter/material.dart';
import 'package:portfolio_uix/features/hangman/data/models/game_model.dart';

import '../../../../core/palette/palette.dart';

class NotificationDialog extends StatelessWidget {
  final GameModel gameModel;

  const NotificationDialog({Key? key, required final this.gameModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isGameLost = gameModel.hiddenWord.contains('_');
    return AlertDialog(
      title: isGameLost
          ? const Text('Вы проиграли!', textAlign: TextAlign.center)
          : const Text('Вы выиграли!', textAlign: TextAlign.center),
      content: isGameLost
          ? RichText(
              text: TextSpan(
                text: 'Было загадано слово\n',
                style: Theme.of(context).textTheme.subtitle1,
                children: <TextSpan>[
                  TextSpan(
                    text: gameModel.word.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            )
          : null,
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Дальше'),
          style: ElevatedButton.styleFrom(primary: Palette.red),
        ),
      ],
      // contentTextStyle: TextStyle(),
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
