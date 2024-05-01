import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/strings.dart';
import 'package:wordle/providers/tile_controller.dart';

class WordEntry extends StatefulWidget {
  const WordEntry({super.key});

  @override
  State<WordEntry> createState() => _WordEntryState();
}

class _WordEntryState extends State<WordEntry> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String word = "";
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.22,
            ),
            const Center(
              child: Text(
                type,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 5,
                autofocus: true,
                controller: controller,
                onChanged: (value) => {word = value},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.06,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[500],
                      foregroundColor: Colors.white),
                  onPressed: () {
                    word = word.toUpperCase();
                    word = word.trim();
                    if (word.length == 5) {
                      Provider.of<TileController>(context, listen: false)
                          .setCorrectWord(word: word);
                      Navigator.pushNamed(context, gamePage);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                fixedSize: Size(
                                  size.width * 0.8,
                                  size.height * 0.06,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(close),
                            )
                          ],
                          content: SizedBox(
                            height: size.height * 0.2,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height * 0.1,
                                ),
                                const Text(
                                  textAlign: TextAlign.center,
                                  validWord,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(start),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
