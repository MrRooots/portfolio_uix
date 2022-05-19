import 'package:flutter/material.dart';

import '../../data/models/game_model.dart';
import 'char_button.dart';

class GameKeyboard extends StatelessWidget {
  final GameModel gameModel;

  const GameKeyboard({Key? key, required final this.gameModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        TableRow(
          children: [0, 1, 2, 3, 4, 5, 7, 8]
              .map((e) => TableCell(
                  child: CharacterButton(index: e, gameModel: gameModel)))
              .toList(),
        ),
        TableRow(
          children: [9, 10, 11, 12, 13, 14, 15, 16]
              .map((e) => TableCell(
                  child: CharacterButton(index: e, gameModel: gameModel)))
              .toList(),
        ),
        TableRow(
          children: [17, 18, 19, 20, 21, 22, 23, 24]
              .map((e) => TableCell(
                  child: CharacterButton(index: e, gameModel: gameModel)))
              .toList(),
        ),
        TableRow(
          children: [
            // const TableCell(child: Text('')),
            ...[25, 26, 27, 28, 29, 30, 31, 32].map((e) => TableCell(
                child: CharacterButton(index: e, gameModel: gameModel))),
            // const TableCell(child: Text('')),
          ],
        ),
      ],
    );
  }
}
