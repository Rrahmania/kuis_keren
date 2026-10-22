
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/answer_option.dart';
import '../widgets/primary_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Keluar dari kuis?'),
        content: const Text(
          'Progres jawabanmu akan tetap tersimpan jika '
              'kamu kembali ke kuis ini. Yakin ingin keluar?',
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, false),
            child: const Text('Lanjutkan'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(dialogContext, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );

    if (leave == true && context.mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;
    final selected = quiz.selectedAnswer;
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Keluar',
          icon: const Icon(Icons.close_rounded),
          onPressed: () => confirmExit(context),
        ),
        title: Text('Halo, ${quiz.playerName}'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${quiz.currentIndex + 1}/${quiz.totalQuestions}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(wide ? 32 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Progres pengerjaan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${(quiz.progress * 100).round()}%',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: quiz.progress,
                    minHeight: 10,
                    backgroundColor:
                    Theme.of(context).dividerColor,
                    color: const Color(0xFFFFC928),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE082),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    question.category,
                    style: const TextStyle(
                      color: Color(0xFF493800),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Pertanyaan ${quiz.currentIndex + 1}',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(color: const Color(0xFFE0A800)),
                ),
                const SizedBox(height: 10),
                Text(
                  question.question,
                  style: TextStyle(
                    fontSize: wide ? 27 : 23,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 26),
                ...List.generate(question.options.length, (i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AnswerOption(
                      label: String.fromCharCode(65 + i),
                      text: question.options[i],
                      selected: selected == i,
                      onTap: () => quiz.selectAnswer(i),
                    ),
                  );
                }),
                if (selected != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              selected == question.correctAnswerIndex
                                  ? Icons.check_circle
                                  : Icons.info_outline,
                              color: selected ==
                                  question.correctAnswerIndex
                                  ? Colors.green
                                  : const Color(0xFFE0A800),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              selected == question.correctAnswerIndex
                                  ? 'Jawaban benar!'
                                  : 'Belum tepat',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(question.explanation),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 28),
                if (quiz.currentIndex > 0) ...[
                  PrimaryButton(
                    text: 'Soal Sebelumnya',
                    icon: Icons.arrow_back,
                    outlined: true,
                    onPressed: quiz.previousQuestion,
                  ),
                  const SizedBox(height: 12),
                ],
                PrimaryButton(
                  text: quiz.isLastQuestion
                      ? 'Lihat Hasil'
                      : 'Soal Berikutnya',
                  icon: quiz.isLastQuestion
                      ? Icons.emoji_events
                      : Icons.arrow_forward,
                  onPressed: () {
                    if (selected == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Pilih jawaban terlebih dahulu.',
                          ),
                        ),
                      );
                      return;
                    }

                    if (quiz.isLastQuestion) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ResultScreen(),
                        ),
                      );
                    } else {
                      quiz.nextQuestion();
                    }
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
