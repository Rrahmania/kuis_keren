
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import 'quiz_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController nameController =
  TextEditingController();

  String selectedCategory = 'Semua';

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Semua',
      'subtitle': 'Semua topik',
      'icon': Icons.grid_view_rounded,
    },
    {
      'title': 'Pengetahuan Umum',
      'subtitle': 'Wawasan umum',
      'icon': Icons.public_rounded,
    },
    {
      'title': 'Teknologi',
      'subtitle': 'Dunia teknologi',
      'icon': Icons.computer_rounded,
    },
    {
      'title': 'Sains',
      'subtitle': 'Ilmu pengetahuan',
      'icon': Icons.science_rounded,
    },
  ];

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void startQuiz() {
    final name = nameController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Masukkan nama kamu terlebih dahulu!'),
        ),
      );
      return;
    }

    final provider = context.read<QuizProvider>();

    provider.startQuiz(name, selectedCategory);

    if (provider.totalQuestions == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Belum ada soal untuk kategori ini.',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const QuizScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Kuis Pintar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Ganti tema',
            icon: Icon(
              context.watch<QuizProvider>().isDarkMode
                  ? Icons.light_mode_rounded
                  : Icons.dark_mode_rounded,
            ),
            onPressed: () {
              final provider = context.read<QuizProvider>();
              provider.toggleTheme(!provider.isDarkMode);
            },
          ),
          IconButton(
            tooltip: 'Riwayat kuis',
            icon: const Icon(Icons.history_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoryScreen(),
                ),
              );
            },
          ),
          IconButton(
            tooltip: 'Pengaturan',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final horizontalPadding =
            constraints.maxWidth < 600 ? 24.0 : 40.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                20,
                horizontalPadding,
                32,
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
                      // HERO BANNER
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFC928),
                          borderRadius:
                          BorderRadius.circular(26),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.lightbulb_rounded,
                              size: 38,
                              color: Color(0xFF242424),
                            ),

                            const SizedBox(height: 20),

                            Text(
                              'Uji Pengetahuanmu!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: const Color(
                                  0xFF242424,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            const Text(
                              'Belajar hal baru, jawab pertanyaan, '
                                  'dan raih skor terbaikmu.',
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: Color(0xFF242424),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // INPUT NAMA
                      Text(
                        'Siapa nama kamu?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: nameController,
                        textCapitalization:
                        TextCapitalization.words,
                        decoration: InputDecoration(
                          hintText: 'Masukkan nama kamu',
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                          ),
                          filled: true,
                          fillColor: Theme.of(context).colorScheme.surface,
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 18,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(16),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: Color(0xFFFFB800),
                              width: 2,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 26),

                      // JUDUL KATEGORI
                      Text(
                        'Pilih kategori',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 12),

                      // KOTAK-KOTAK KATEGORI
                      LayoutBuilder(
                        builder: (context, categoryConstraints) {
                          final columns =
                          categoryConstraints.maxWidth >= 600
                              ? 3
                              : 2;

                          final spacing = 12.0;

                          final cardWidth =
                              (categoryConstraints.maxWidth -
                                  spacing * (columns - 1)) /
                                  columns;

                          return Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            children: categories.map((category) {
                              final title =
                              category['title'] as String;
                              final subtitle =
                              category['subtitle'] as String;
                              final icon =
                              category['icon'] as IconData;

                              final isSelected =
                                  selectedCategory == title;

                              return SizedBox(
                                width: cardWidth,
                                child: _CategoryCard(
                                  title: title,
                                  subtitle: subtitle,
                                  icon: icon,
                                  isSelected: isSelected,
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = title;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                      // TOMBOL MULAI
                      PrimaryButton(
                        text: 'Mulai Kuis',
                        icon: Icons.play_arrow_rounded,
                        onPressed: startQuiz,
                      ),

                      const SizedBox(height: 18),

                      // INFORMASI FITUR
                      const _FeatureInfo(
                        icon: Icons.check_circle_outline,
                        text:
                        'Soal pilihan ganda dengan pembahasan',
                      ),

                      const SizedBox(height: 8),

                      const _FeatureInfo(
                        icon: Icons.emoji_events_outlined,
                        text: 'Lihat hasil dan riwayat kuis',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// WIDGET KARTU KATEGORI
class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardBg = isSelected
        ? (isDark ? const Color(0xFF4A3B00) : const Color(0xFFFFF0BD))
        : Theme.of(context).colorScheme.surface;
    final borderColor = isSelected
        ? const Color(0xFFFFB800)
        : (isDark ? const Color(0xFF383838) : const Color(0xFFE5E0D5));
    final textColor = Theme.of(context).colorScheme.onSurface;
    final subtitleColor = isDark ? Colors.white70 : const Color(0xFF716B60);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: borderColor,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 25,
                      color: textColor,
                    ),
                    const Spacer(),
                    if (isSelected)
                      const Icon(
                        Icons.check_circle_rounded,
                        color: Color(0xFFFFB800),
                        size: 20,
                      ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// WIDGET INFORMASI FITUR
class _FeatureInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureInfo({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8);

    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: color,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
