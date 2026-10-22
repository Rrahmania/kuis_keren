
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController =
  TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void startQuiz() {
    final quiz = context.read<QuizProvider>();

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nama kamu terlebih dahulu.'),
        ),
      );
      return;
    }

    quiz.setPlayerName(nameController.text);
    quiz.startQuiz();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final size = MediaQuery.sizeOf(context);
    final wide = size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kuis Pintar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            onPressed: quiz.toggleTheme,
            icon: Icon(
              quiz.isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(wide ? 32 : 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(wide ? 32 : 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD54F),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        size: 54,
                        color: Color(0xFF493800),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Uji Pengetahuanmu!',
                        style: TextStyle(
                          fontSize: wide ? 30 : 26,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF302500),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Jawab pertanyaan, kumpulkan poin, '
                            'dan lihat seberapa hebat kemampuanmu.',
                        style: TextStyle(
                          color: Color(0xFF493800),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'Siapa nama kamu?',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan nama peserta',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Pilih kategori',
                  style: Theme.of(context).textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: quiz.selectedCategory,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category_outlined),
                  ),
                  items: quizCategories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      quiz.setCategory(value);
                    }
                  },
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.quiz_outlined,
                        color: Color(0xFFE0A800),
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Informasi kuis',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${quiz.totalQuestions} soal • '
                                  '10 poin untuk setiap jawaban benar',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                PrimaryButton(
                  text: 'Mulai Kuis',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: startQuiz,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
