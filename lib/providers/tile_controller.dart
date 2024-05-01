import 'package:flutter/material.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/data/keys_map.dart';
import 'package:wordle/models/tile_model.dart';
import 'package:wordle/widgets/score.dart';

class TileController extends ChangeNotifier {
  int currentTile = 0;
  int currentRow = 0;

  int correctLetter = 0;
  int containsLetter = 0;

  String correctWord = "";

  List<TileModal> tilesEntered = [];

  setCorrectWord({required String word}) => correctWord = word;

  setKeyTapped({required String value, required context}) {
    switch (value) {
      case "ENTER":
        if (currentTile == 5 * (currentRow + 1)) {
          checkWord();
          calculateScore(context);
        }

        break;
      case "DELETE":
        if (currentTile > 5 * (currentRow + 1) - 5) {
          currentTile--;
          tilesEntered.removeLast();
        }

        break;
      default:
        if (currentTile < 5 * (currentRow + 1)) {
          currentTile++;
          tilesEntered.add(
            TileModal(
              letter: value,
              answerStage: AnswerStage.notAnswered,
            ),
          );
        }
    }
    notifyListeners();
  }

  checkWord() {
    String guessedWord = "";

    List<String> remainingCorrect = [];
    List<String> guessed = [];

    for (var i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      guessed.add(tilesEntered[i].letter);
    }
    guessedWord = guessed.join();
    remainingCorrect = correctWord.characters.toList();

    if (guessedWord == correctWord) {
      for (var i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
        tilesEntered[i].answerStage = AnswerStage.correct;
        keysMap.update(tilesEntered[i].letter, (value) => AnswerStage.correct);
      }
    } else {
      for (var i = 0; i < 5; i++) {
        if (guessedWord[i] == correctWord[i]) {
          remainingCorrect.remove(guessedWord[i]);
          tilesEntered[i + (currentRow * 5)].answerStage = AnswerStage.correct;
          keysMap.update(guessedWord[i], (value) => AnswerStage.correct);
        }
      }
    }

    for (int i = 0; i < remainingCorrect.length; i++) {
      for (int j = 0; j < 5; j++) {
        if (remainingCorrect[i] == tilesEntered[j + (currentRow * 5)].letter) {
          if (tilesEntered[j + (currentRow * 5)].answerStage !=
              AnswerStage.correct) {
            tilesEntered[j + (currentRow * 5)].answerStage =
                AnswerStage.contains;
          }

          final resultKey = keysMap.entries.where((element) =>
              element.key == tilesEntered[j + (currentRow * 5)].letter);

          if (resultKey.single.value != AnswerStage.correct) {
            keysMap.update(
                resultKey.single.key, (value) => AnswerStage.contains);
          }
        }
      }
    }
    for (int i = currentRow * 5; i < (currentRow * 5) + 5; i++) {
      if (tilesEntered[i].answerStage == AnswerStage.notAnswered) {
        tilesEntered[i].answerStage = AnswerStage.incorrect;

        final results = keysMap.entries
            .where((element) => element.key == tilesEntered[i].letter);
        if (results.single.value == AnswerStage.notAnswered) {
          keysMap.update(
              tilesEntered[i].letter, (value) => AnswerStage.incorrect);
        }
      }
    }

    currentRow++;
    notifyListeners();
  }

  calculateScore(BuildContext context) {
    for (int i = (currentRow * 5) - 5; i < (currentRow * 5); i++) {
      if (tilesEntered[i].answerStage == AnswerStage.correct) {
        correctLetter++;
      } else if (tilesEntered[i].answerStage == AnswerStage.contains) {
        containsLetter++;
      }
    }
    int score = (correctLetter * 10 + containsLetter * 5);

    if (correctLetter == 5) {
      showDialog(
        context: context,
        builder: (context) =>
            Score(isPlayerWin: true, playerScore: score, otherPlayersScore: 30),
      );
    }
    if (currentRow == 5) {
      showDialog(
        context: context,
        builder: (context) =>
            Score(isPlayerWin: true, playerScore: score, otherPlayersScore: 30),
      );
    }
    correctLetter = 0;
    containsLetter = 0;
  }

  cleanGrid() {
    currentTile = 0;
    currentRow = 0;
    correctLetter = 0;
    containsLetter = 0;
    correctWord = "";
    tilesEntered = [];
    for (int i = 0; i < keysMap.length; i++) {
      keysMap[keysMap.keys.elementAt(i)] = AnswerStage.notAnswered;
    }
    notifyListeners();
  }
}
