import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/providers/tile_controller.dart';

class Tile extends StatefulWidget {
  const Tile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<Tile> createState() => _TileState();
}

class _TileState extends State<Tile> {
  Color _tileColor = Colors.transparent;
  Color _borderColor = lightThemeLight;
  late AnswerStage _answerStage;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _borderColor = Theme.of(context).primaryColorLight;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TileController>(
      builder: (context, notifier, child) {
        String text = "";
        Color fontColor = Colors.white;
        if (widget.index < notifier.tilesEntered.length) {
          text = notifier.tilesEntered[widget.index].letter;
          _answerStage = notifier.tilesEntered[widget.index].answerStage;
          if (_answerStage == AnswerStage.correct) {
            _tileColor = correct;
            _borderColor = Colors.transparent;
          } else if (_answerStage == AnswerStage.contains) {
            _borderColor = Colors.transparent;
            _tileColor = contains;
          } else if (_answerStage == AnswerStage.incorrect) {
            _borderColor = Colors.transparent;
            _tileColor = Theme.of(context).primaryColorDark;
          } else {
            fontColor =
                Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
          }
          return Container(
            decoration: BoxDecoration(
              color: _tileColor,
              border: Border.all(color: _borderColor),
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  text,
                  style: const TextStyle().copyWith(color: fontColor),
                ),
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              color: _tileColor,
              border: Border.all(color: _borderColor),
            ),
          );
        }
      },
    );
  }
}
