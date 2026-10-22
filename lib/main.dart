
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: const KuisPintarApp(),
    ),
  );
}

class KuisPintarApp extends StatelessWidget {
  const KuisPintarApp({super.key});

  ThemeData buildTheme(bool dark) {
    const yellow = Color(0xFFFFD54F);

    return ThemeData(
      useMaterial3: true,
      brightness: dark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor:
      dark ? const Color(0xFF181818) : const Color(0xFFFFFBF0),
      colorScheme: ColorScheme.fromSeed(
        seedColor: yellow,
        brightness: dark ? Brightness.dark : Brightness.light,
        primary: const Color(0xFFE0A800),
        secondary: yellow,
      ),
      cardColor: dark ? const Color(0xFF262626) : Colors.white,
      dividerColor: dark ? Colors.white24 : Colors.black12,
      fontFamily: 'Poppins',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: dark ? const Color(0xFF262626) : Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kuis Pintar',
          theme: buildTheme(false),
          darkTheme: buildTheme(true),
          themeMode: quiz.isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
          home: const HomeScreen(),
        );
      },
    );
  }
}
