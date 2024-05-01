import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/answer_stages.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/data/keys_map.dart';
import 'package:wordle/providers/tile_controller.dart';

// class KeyboardRow extends StatelessWidget {
//   const KeyboardRow({
//     super.key,
//     required this.min,
//     required this.max,
//   });

//   final int min, max;

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Consumer<TileController>(
//       builder: (context, value, child) {
//         int index = 0;
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: keysMap.entries.map((e) {
//             index++;
//             if (index < min || index > max) {
//             Color color = defaultColor;
//               if (e.value == AnswerStage.correct) {
//                 color = correct;
//               } else if (e.value == AnswerStage.contains) {
//                 color = contains;
//               }

//               return const SizedBox.shrink();
//             } else {
//               return Padding(
//                 padding: EdgeInsets.all(size.width * 0.004),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(6),
//                   child: SizedBox(
//                     width: e.key == 'ENTER' || e.key == 'DELETE'
//                         ? size.width * 0.12
//                         : size.width * 0.080,
//                     height: size.height * 0.09,
//                     child: Material(
//                       color: color,
//                       child: InkWell(
//                         onTap: () {
//                           Provider.of<TileController>(context, listen: false)
//                               .setKeyTapped(value: e.key);
//                         },
//                         child: Center(
//                           child: Text(e.key),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }).toList(),
//         );
//       },
//     );
//   }
// }

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    required this.min,
    required this.max,
    super.key,
  });

  final int min, max;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Consumer<TileController>(
      builder: (_, notifier, __) {
        int index = 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: keysMap.entries.map(
            (e) {
              index++;
              if (index >= min && index <= max) {
                Color color = Theme.of(context).primaryColorLight;
                Color keyColor = Colors.white;
                if (e.value == AnswerStage.correct) {
                  color = correct;
                } else if (e.value == AnswerStage.contains) {
                  color = contains;
                } else if (e.value == AnswerStage.incorrect) {
                  color = Theme.of(context).primaryColorDark;
                } else {
                  keyColor = Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black;
                }
                return Padding(
                  padding: EdgeInsets.all(size.width * 0.006),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: SizedBox(
                      width: e.key == 'ENTER' || e.key == 'DELETE'
                          ? size.width * 0.12
                          : size.width * 0.075,
                      height: size.height * 0.09,
                      child: Material(
                        color: color,
                        child: InkWell(
                          onTap: () {
                            Provider.of<TileController>(context, listen: false)
                                .setKeyTapped(value: e.key, context: context);
                          },
                          child: Center(
                            child: e.key == 'DELETE'
                                ? const Icon(
                                    Icons.backspace_outlined,
                                    color: Colors.white,
                                  )
                                : Text(
                                    e.key,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: keyColor,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ).toList(),
        );
      },
    );
  }
}
