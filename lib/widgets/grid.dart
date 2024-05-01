import 'package:flutter/material.dart';
import 'package:wordle/widgets/tile.dart';

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemCount: 25,
      itemBuilder: (BuildContext context, int index) {
        return Tile(
          index: index,
        );
      },
    );
  }
}
