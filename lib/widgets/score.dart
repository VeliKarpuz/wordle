import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/constants/strings.dart';
import 'package:wordle/providers/tile_controller.dart';

class Score extends StatelessWidget {
  const Score(
      {super.key,
      required this.isPlayerWin,
      required this.playerScore,
      required this.otherPlayersScore});

  final bool isPlayerWin;
  final int playerScore;
  final int otherPlayersScore;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AlertDialog(
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text(duel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  ModalRoute.withName(homePage),
                );
                Provider.of<TileController>(context, listen: false).cleanGrid();
              },
              child: const Text(close),
            ),
          ],
        ),
      ],
      content: SizedBox(
        height: size.height * 0.5,
        width: size.width * 0.8,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(
              isPlayerWin ? win : lose,
              style: TextStyle(
                color: isPlayerWin ? correct : loseGame,
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Text(
              "$score $playerScore ",
              style: const TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Text(
              "$otherScore $otherPlayersScore",
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            const Text(
              duelloText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
