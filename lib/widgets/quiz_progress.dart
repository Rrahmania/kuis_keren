import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class QuizProgress extends StatelessWidget {
  final int current;
  final int total;

  const QuizProgress({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : current / total;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Progres kuis',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text('$current dari $total'),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 9,
            backgroundColor: Theme.of(context)
                .colorScheme
                .onSurface
                .withValues(alpha: 0.15),
            color: AppTheme.yellow,
          ),
        ),
      ],
    );
  }
}