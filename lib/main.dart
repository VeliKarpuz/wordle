import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/constants/colors.dart';
import 'package:wordle/constants/strings.dart';
import 'package:wordle/screens/auth_page.dart';
import 'package:wordle/screens/game_page.dart';
import 'package:wordle/screens/home_page.dart';
import 'package:wordle/providers/tile_controller.dart';
import 'package:wordle/screens/word_entry_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TileController(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'wordle',
      theme: ThemeData(
        useMaterial3: true,
        primaryColorLight: lightThemeLight,
        primaryColorDark: lightThemeDark,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: const TextTheme().copyWith(
          bodyMedium: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: lightThemeLight,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              fixedSize: Size(size.width * 0.25, size.height * 0.1)),
        ),
      ),
      routes: {
        homePage: (context) => const HomePage(),
        gamePage: (context) => const Gamepage(),
        wordEntry: (context) => const WordEntry(),
        authPage: (context) => const AuthPage(),
      },
    );
  }
}
