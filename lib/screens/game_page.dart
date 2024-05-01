import 'package:flutter/material.dart';
import 'package:wordle/constants/strings.dart';
import 'package:wordle/widgets/back_button.dart';
import 'package:wordle/widgets/grid.dart';
import 'package:wordle/widgets/keyboard_row.dart';

class Gamepage extends StatelessWidget {
  const Gamepage({
    super.key,
  });

  @override
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(size: size),
        title: const Text(wordle),
        centerTitle: true,
      ),
      body: const Column(
        children: [
          Divider(
            height: 1,
            thickness: 2,
          ),
          Expanded(
            flex: 6,
            child: Grid(),
          ),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                KeyboardRow(min: 1, max: 10),
                KeyboardRow(min: 11, max: 21),
                KeyboardRow(min: 22, max: 31),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
