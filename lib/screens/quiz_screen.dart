
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/answer_card.dart';
import '../widgets/quiz_progress.dart';
import '../widgets/primary_button.dart';
import 'result_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, provider, child) {
        // Jika semua soal sudah selesai, tampilkan halaman hasil.
        if (provider.isFinished) {
          return const ResultScreen();
        }

        final question = provider.currentQuestion;
        final hasAnswered =
        provider.answers.containsKey(question.id);

        final selectedIndex = provider.answers[question.id];

        final isDark = Theme.of(context).brightness == Brightness.dark;

        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;

            final shouldExit = await showDialog<bool>(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: const Text('Keluar dari kuis?'),
                  content: const Text(
                    'Progres jawabanmu akan tetap tersimpan '
                        'selama sesi kuis ini berlangsung.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(dialogContext, false);
                      },
                      child: const Text('Lanjut kuis'),
                    ),
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(dialogContext, true);
                      },
                      child: const Text('Keluar'),
                    ),
                  ],
                );
              },
            );

            if (shouldExit == true && context.mounted) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  final shouldExit = await showDialog<bool>(
                    context: context,
                    builder: (dialogContext) {
                      return AlertDialog(
                        title: const Text('Keluar dari kuis?'),
                        content: const Text(
                          'Apakah kamu yakin ingin meninggalkan kuis?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, false);
                            },
                            child: const Text('Batal'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(dialogContext, true);
                            },
                            child: const Text('Keluar'),
                          ),
                        ],
                      );
                    },
                  );

                  if (shouldExit == true && context.mounted) {
                    Navigator.pop(context);
                  }
                },
                tooltip: 'Kembali',
              ),
              title: const Text(
                'Kuis Pintar',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                      constraints.maxWidth < 600 ? 20 : 40,
                      vertical: 20,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: 700,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [
                            // Informasi pengguna dan kategori.
                            Text(
                              'Semangat, ${provider.userName}!',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              'niegori: ${provider.selectedCategory}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.7),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Progress kuis.
                            QuizProgress(
                              current: provider.currentIndex + 1,
                              total: provider.totalQuestions,
                            ),

                            const SizedBox(height: 28),

                            // Kartu pertanyaan.
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius:
                                BorderRadius.circular(24),
                                border: Border.all(
                                  color: isDark
                                      ? const Color(0xFF494949)
                                      : const Color(0xFFFFE08A),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withValues(alpha: 0.04),
                                    blurRadius: 16,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isDark
                                          ? const Color(0xFF4A3B00)
                                          : const Color(0xFFFFF0BD),
                                      borderRadius:
                                      BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Soal ${provider.currentIndex + 1}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? const Color(0xFFFFD966)
                                            : const Color(0xFF765400),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  Text(
                                    question.question,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 24),

                            const Text(
                              'Pilih jawaban yang benar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Daftar pilihan jawaban.
                            ...List.generate(
                              question.options.length,
                                  (index) {
                                final isSelected =
                                    selectedIndex == index;

                                return Padding(
                                  padding:
                                  const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: AnswerCard(
                                    text: question.options[index],
                                    index: index,
                                    selected: isSelected,

                                    // Perbaikan error isCorrect.
                                    isCorrect: !hasAnswered
                                        ? null
                                        : (index ==
                                        question.correctIndex
                                        ? true
                                        : (isSelected
                                        ? false
                                        : null)),

                                    onTap: () {
                                      provider.selectAnswer(index);
                                    },
                                  ),
                                );
                              },
                            ),

                            // Penjelasan muncul setelah menjawab.
                            if (hasAnswered) ...[
                              const SizedBox(height: 8),

                              Builder(
                                builder: (context) {
                                  final isCorrectAnswer =
                                      selectedIndex == question.correctIndex;
                                  final explanationBg = isCorrectAnswer
                                      ? (isDark
                                          ? const Color(0xFF1B3820)
                                          : const Color(0xFFE4F7E8))
                                      : (isDark
                                          ? const Color(0xFF3E1A1A)
                                          : const Color(0xFFFFE8E5));
                                  final statusColor = isCorrectAnswer
                                      ? (isDark
                                          ? const Color(0xFF81C784)
                                          : Colors.green)
                                      : (isDark
                                          ? const Color(0xFFE57373)
                                          : Colors.red);

                                  return Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: explanationBg,
                                      borderRadius:
                                      BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              isCorrectAnswer
                                                  ? Icons.check_circle
                                                  : Icons.info,
                                              color: statusColor,
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Text(
                                                isCorrectAnswer
                                                    ? 'Jawaban benar!'
                                                    : 'Belum tepat!',
                                                style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color: statusColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 8),

                                        Text(
                                          question.explanation,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],

                            const SizedBox(height: 28),

                            // Tombol navigasi soal.
                            Row(
                              children: [
                                Expanded(
                                  child: OutlinedButton.icon(
                                    onPressed:
                                    provider.currentIndex > 0
                                        ? provider.previousQuestion
                                        : null,
                                    icon: const Icon(
                                      Icons.arrow_back,
                                    ),
                                    label: const Text('Sebelumnya'),
                                    style: OutlinedButton.styleFrom(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        vertical: 16,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: PrimaryButton(
                                    text: provider.currentIndex ==
                                        provider.totalQuestions - 1
                                        ? 'Lihat Hasil'
                                        : 'Berikutnya',
                                    icon: provider.currentIndex ==
                                        provider.totalQuestions - 1
                                        ? Icons.emoji_events
                                        : Icons.arrow_forward,
                                    onPressed: () {
                                      if (provider.currentIndex <
                                          provider.totalQuestions - 1) {
                                        provider.nextQuestion();
                                      } else {
                                        provider.finishQuiz();
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Informasi jumlah soal yang dijawab.
                            Center(
                              child: Text(
                                '${provider.answeredCount} dari '
                                    '${provider.totalQuestions} soal dijawab',
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
