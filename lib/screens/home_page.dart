import 'package:flutter/material.dart';
import 'package:wordle/constants/strings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: size.height * 0.3,
          ),
          const Center(
            child: Text(
              wordle,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
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
                  Navigator.pushNamed(context, wordEntry);
                },
                child: const Text(start),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
