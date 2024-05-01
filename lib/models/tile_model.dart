import 'package:wordle/constants/answer_stages.dart';

class TileModal {
  final String letter;
  AnswerStage answerStage;

  TileModal({required this.letter, required this.answerStage});
}
