import 'package:flutter/material.dart';

class RecordTile extends StatelessWidget {
  final int record;
  final int rank;

  const RecordTile({
    Key? key,
    required final this.record,
    required final this.rank,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getImage() ?? Container(),
        const SizedBox(width: 10),
        Text(
          'Guessed ${record.toString()} word${record != 1 ? 's in a row' : ''}',
          style: TextStyle(fontSize: _getFontSize()),
        ),
      ],
    );
  }

  Image? _getImage() {
    String path;
    switch (rank) {
      case 0:
        path = 'assets/img/hangman/first.png';
        break;
      case 1:
        path = 'assets/img/hangman/second.png';
        break;
      case 2:
        path = 'assets/img/hangman/third.png';
        break;
      default:
        return null;
    }

    return Image.asset(path, height: 60, width: 60, fit: BoxFit.fill);
  }

  double _getFontSize() {
    return rank == 0
        ? 22.0
        : rank == 1
            ? 20.0
            : rank == 3
                ? 18.0
                : 16.0;
  }
}
