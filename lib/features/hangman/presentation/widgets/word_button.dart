import 'package:flutter/material.dart';
import 'package:portfolio_uix/core/palette/palette.dart';

class WordButton extends StatelessWidget {
  final void Function()? onPressed;
  final String character;

  const WordButton({
    Key? key,
    required final this.character,
    required final this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(5.0),
        primary: Palette.lightOrange,
      ),
      onPressed: onPressed,
      child: Text(
        character,
        textAlign: TextAlign.center,
      ),
    );
  }
}
