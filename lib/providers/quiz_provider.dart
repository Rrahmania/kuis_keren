
import 'package:flutter/material.dart';
import '../data/quiz_data.dart';
import '../models/question.dart';

class QuizProvider extends ChangeNotifier {

  bool isDarkMode = false;

  void toggleTheme(bool value) {
    isDarkMode = value;
    notifyListeners();
  }


  String userName = '';
  String selectedCategory = 'Semua';
  int currentIndex = 0;

  final Map<String, int> answers = {};

  bool isFinished = false;

  final List<Map<String, dynamic>> history = [];

  List<Question> _currentQuestions = [];

  List<Question> get questions {
    if (_currentQuestions.isEmpty) {
      _currentQuestions = selectedCategory == 'Semua'
          ? List<Question>.from(quizQuestions)
          : quizQuestions
              .where((question) => question.category == selectedCategory)
              .toList();
    }
    return _currentQuestions;
  }

  int get totalQuestions => questions.length;

  Question get currentQuestion => questions[currentIndex];

  bool get hasQuestions => questions.isNotEmpty;

  bool get hasAnsweredCurrentQuestion {
    if (!hasQuestions) return false;

    return answers.containsKey(currentQuestion.id);
  }

  int? get selectedAnswer {
    if (!hasQuestions) return null;

    return answers[currentQuestion.id];
  }

  // ==========================================
  // PERHITUNGAN SKOR
  // ==========================================

  int get answeredCount => answers.length;

  int get correctCount {
    int count = 0;

    for (final question in questions) {
      final answer = answers[question.id];

      if (answer != null &&
          answer == question.correctIndex) {
        count++;
      }
    }

    return count;
  }

  int get wrongCount => answeredCount - correctCount;

  int get unansweredCount =>
      totalQuestions - answeredCount;

  double get score {
    if (totalQuestions == 0) return 0;

    return (correctCount / totalQuestions) * 100;
  }

  void startQuiz(String name, String category) {
    userName = name.trim();
    selectedCategory = category;

    List<Question> list;
    if (selectedCategory == 'Semua') {
      list = List<Question>.from(quizQuestions);
    } else {
      list = quizQuestions
          .where(
            (question) => question.category == selectedCategory,
          )
          .toList();
    }

    // Mengacak urutan soal agar berbeda tiap kali kuis dimulai/diulang
    list.shuffle();
    _currentQuestions = list;

    currentIndex = 0;
    answers.clear();
    isFinished = false;

    notifyListeners();
  }

  void selectAnswer(int index) {
    if (!hasQuestions || isFinished) return;
    if (hasAnsweredCurrentQuestion) return;

    if (index < 0 ||
        index >= currentQuestion.options.length) {
      return;
    }

    answers[currentQuestion.id] = index;

    notifyListeners();
  }

  void nextQuestion() {
    if (!hasQuestions || isFinished) return;

    if (currentIndex < totalQuestions - 1) {
      currentIndex++;
      notifyListeners();
    }
  }

  void previousQuestion() {
    if (!hasQuestions || isFinished) return;

    if (currentIndex > 0) {
      currentIndex--;
      notifyListeners();
    }
  }

  void goToQuestion(int index) {
    if (!hasQuestions || isFinished) return;

    if (index >= 0 && index < totalQuestions) {
      currentIndex = index;
      notifyListeners();
    }
  }


  void finishQuiz() {
    if (isFinished || !hasQuestions) return;

    isFinished = true;

    history.insert(0, {
      'name': userName,
      'category': selectedCategory,
      'score': score,
      'correct': correctCount,
      'wrong': wrongCount,
      'total': totalQuestions,
      'date': DateTime.now(),
    });

    notifyListeners();
  }

  // ==========================================
  // MENGULANG KUIS DENGAN KATEGORI YANG SAMA
  // ==========================================

  void retryQuiz() {
    if (userName.isEmpty) return;

    startQuiz(userName, selectedCategory);
  }

  // ==========================================
  // MENGHAPUS RIWAYAT KUIS
  // ==========================================

  void clearHistory() {
    history.clear();
    notifyListeners();
  }

  // ==========================================
  // MENGHAPUS SATU RIWAYAT
  // ==========================================

  void removeHistory(int index) {
    if (index < 0 || index >= history.length) {
      return;
    }

    history.removeAt(index);
    notifyListeners();
  }

  // ==========================================
  // RESET STATUS KUIS
  // ==========================================

  void resetQuiz() {
    currentIndex = 0;
    answers.clear();
    isFinished = false;

    notifyListeners();
  }
}
