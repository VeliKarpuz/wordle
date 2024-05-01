import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/strings.dart';
import 'package:wordle/providers/tile_controller.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(size.width * 0.3, size.height * 0.06)),
                      onPressed: () {
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(homePage),
                        );
                        Provider.of<TileController>(context, listen: false)
                            .cleanGrid();
                      },
                      child: const Text(accept),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(size.width * 0.3, size.height * 0.06)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(reject),
                    ),
                  ],
                ),
              ],
              content: SizedBox(
                height: size.height * 0.3,
                child: const Text(
                  textAlign: TextAlign.center,
                  backQuestion,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        },
        icon: const Icon(Icons.arrow_back));
  }
}
