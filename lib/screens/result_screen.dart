
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 600;

    String message;
    if (quiz.percentage >= 80) {
      message = 'Luar biasa! Kamu menguasai materi ini.';
    } else if (quiz.percentage >= 60) {
      message = 'Bagus! Terus berlatih agar makin hebat.';
    } else {
      message = 'Jangan menyerah. Coba lagi dan tingkatkan skormu!';
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Hasil Kuis'),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: quiz.toggleTheme,
            icon: Icon(
              quiz.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(wide ? 32 : 22),
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 104,
                  height: 104,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFE082),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 58,
                    color: Color(0xFF8A6500),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Kuis Selesai!',
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hebat, ${quiz.playerName}!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD54F),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'SKOR AKHIR',
                        style: TextStyle(
                          color: Color(0xFF493800),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${quiz.score}',
                        style: TextStyle(
                          fontSize: wide ? 68 : 58,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF302500),
                        ),
                      ),
                      Text(
                        '${quiz.percentage.toStringAsFixed(0)}% benar',
                        style: const TextStyle(
                          color: Color(0xFF493800),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  children: [
                    Expanded(
                      child: _ResultCard(
                        icon: Icons.check_circle_outline,
                        title: 'Benar',
                        value: '${quiz.correctCount}',
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ResultCard(
                        icon: Icons.cancel_outlined,
                        title: 'Salah',
                        value: '${quiz.incorrectCount}',
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _ResultCard(
                        icon: Icons.help_outline,
                        title: 'Kosong',
                        value: '${quiz.totalQuestions - quiz.answeredCount}',
                        color: const Color(0xFFE0A800),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  text: 'Ulangi Kuis',
                  icon: Icons.refresh,
                  onPressed: () {
                    quiz.resetQuiz();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const QuizScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  text: 'Kembali ke Beranda',
                  icon: Icons.home_outlined,
                  outlined: true,
                  onPressed: () {
                    quiz.resetQuiz();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                          (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ResultCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
