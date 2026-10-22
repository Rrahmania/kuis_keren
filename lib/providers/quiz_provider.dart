
import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {
  String playerName = '';
  String selectedCategory = 'Semua Kategori';
  bool isDarkMode = false;

  int currentIndex = 0;
  final Map<int, int> _answers = {};

  List<Question> get questions {
    if (selectedCategory == 'Semua Kategori') {
      return quizQuestions;
    }

    return quizQuestions
        .where((q) => q.category == selectedCategory)
        .toList();
  }

  int get totalQuestions => questions.length;

  Question get currentQuestion => questions[currentIndex];

  int? get selectedAnswer => _answers[currentIndex];

  int get answeredCount => _answers.length;

  int get correctCount {
    int count = 0;
    for (int i = 0; i < questions.length; i++) {
      if (_answers[i] == questions[i].correctAnswerIndex) {
        count++;
      }
    }
    return count;
  }

  int get incorrectCount => answeredCount - correctCount;

  int get score => correctCount * 10;

  double get percentage {
    if (totalQuestions == 0) return 0;
    return correctCount / totalQuestions * 100;
  }

  double get progress {
    if (totalQuestions == 0) return 0;
    return (currentIndex + 1) / totalQuestions;
  }

  bool get isLastQuestion =>
      currentIndex == totalQuestions - 1;

  void setPlayerName(String value) {
    playerName = value.trim();
    notifyListeners();
  }

  void setCategory(String value) {
    selectedCategory = value;
    notifyListeners();
  }

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }

  void selectAnswer(int index) {
    _answers[currentIndex] = index;
    notifyListeners();
  }

  void nextQuestion() {
    if (currentIndex < totalQuestions - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  void startQuiz() {
    currentIndex = 0;
    _answers.clear();
    notifyListeners();
  }

  void resetQuiz() {
    currentIndex = 0;
    _answers.clear();
    notifyListeners();
  }
}
