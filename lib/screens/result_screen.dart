
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/primary_button.dart';
import 'home_screen.dart';
import 'quiz_screen.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(
      builder: (context, quiz, child) {
        final score = quiz.score;
        final isExcellent = score >= 80;
        final isGood = score >= 60 && score < 80;

        final resultTitle = isExcellent
            ? 'Luar Biasa!'
            : isGood
            ? 'Kerja Bagus!'
            : 'Tetap Semangat!';

        final resultMessage = isExcellent
            ? 'Kamu menguasai materi dengan sangat baik.'
            : isGood
            ? 'Hasil yang bagus! Terus tingkatkan kemampuanmu.'
            : 'Jangan menyerah. Coba belajar dan berlatih lagi.';

        return Scaffold(
          backgroundColor:
          Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Hasil Kuis',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                tooltip: 'Kembali ke beranda',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                        (route) => false,
                  );
                },
                icon: const Icon(Icons.home_rounded),
              ),
            ],
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final horizontalPadding =
                constraints.maxWidth < 600 ? 20.0 : 40.0;

                return SingleChildScrollView(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 600,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 12),

                          // IKON HASIL
                          Center(
                            child: Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                color: AppTheme.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                isExcellent
                                    ? Icons.emoji_events_rounded
                                    : isGood
                                    ? Icons.stars_rounded
                                    : Icons.school_rounded,
                                size: 58,
                                color: const Color(0xFF242424),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // SAPAAN PENGGUNA
                          Text(
                            resultTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            'Hebat, ${quiz.userName}!',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 8),

                          Text(
                            resultMessage,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.7),
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 28),

                          // KARTU SKOR
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppTheme.yellow,
                              borderRadius:
                              BorderRadius.circular(24),
                            ),
                            child: Column(
                              children: [
                                const Text(
                                  'SKOR AKHIR',
                                  style: TextStyle(
                                    color: Color(0xFF5C4800),
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  '${score.round()}',
                                  style: const TextStyle(
                                    fontSize: 64,
                                    height: 1.1,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF242424),
                                  ),
                                ),

                                const Text(
                                  'dari 100 poin',
                                  style: TextStyle(
                                    color: Color(0xFF5C4800),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    value: score / 100,
                                    minHeight: 10,
                                    backgroundColor:
                                    Colors.white.withValues(
                                      alpha: 0.55,
                                    ),
                                    valueColor:
                                    const AlwaysStoppedAnimation<
                                        Color>(
                                      Color(0xFF242424),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          // RINGKASAN JAWABAN
                          Text(
                            'Ringkasan Jawaban',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Row(
                            children: [
                              Expanded(
                                child: _ResultStat(
                                  title: 'Benar',
                                  value: '${quiz.correctCount}',
                                  color: AppTheme.green,
                                  icon: Icons.check_circle_rounded,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: _ResultStat(
                                  title: 'Salah',
                                  value: '${quiz.wrongCount}',
                                  color: AppTheme.red,
                                  icon: Icons.cancel_rounded,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: _ResultStat(
                                  title: 'Kosong',
                                  value: '${quiz.unansweredCount}',
                                  color: const Color(0xFFB88600),
                                  icon: Icons.help_rounded,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // INFORMASI KATEGORI
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .surface,
                              borderRadius:
                              BorderRadius.circular(16),
                              border: Border.all(
                                color: Theme.of(context)
                                    .dividerColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.category_rounded,
                                  color: Color(0xFFB88600),
                                  size: 28,
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kategori kuis',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(
                                            alpha: 0.65,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 4),

                                      Text(
                                        quiz.selectedCategory,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Icon(
                                  Icons.check_circle_outline,
                                  color: AppTheme.green,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 28),

                          // COBA LAGI
                          PrimaryButton(
                            text: 'Coba Kuis Lagi',
                            icon: Icons.refresh_rounded,
                            onPressed: () {
                              quiz.retryQuiz();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const QuizScreen(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 12),

                          // KEMBALI KE BERANDA
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                  const HomeScreen(),
                                ),
                                    (route) => false,
                              );
                            },
                            icon: const Icon(
                              Icons.home_rounded,
                            ),
                            label: const Text(
                              'Kembali ke Beranda',
                            ),
                            style: OutlinedButton.styleFrom(
                              padding:
                              const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              foregroundColor: Theme.of(context)
                                  .colorScheme
                                  .onSurface,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(16),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// WIDGET STATISTIK JAWABAN
class _ResultStat extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _ResultStat({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
