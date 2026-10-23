import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AnswerCard extends StatelessWidget {
  final String text;
  final int index;
  final bool selected;
  final bool? isCorrect;
  final VoidCallback onTap;

  const AnswerCard({
    super.key,
    required this.text,
    required this.index,
    required this.selected,
    required this.onTap,
    this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Color borderColor = isDark ? const Color(0xFF383838) : const Color(0xFFE8E1D2);
    Color backgroundColor = Theme.of(context).colorScheme.surface;

    if (isCorrect == true) {
      borderColor = AppTheme.green;
      backgroundColor = isDark ? const Color(0xFF1B3820) : const Color(0xFFE7F7EF);
    } else if (isCorrect == false) {
      borderColor = AppTheme.red;
      backgroundColor = isDark ? const Color(0xFF3E1A1A) : const Color(0xFFFFECEB);
    } else if (selected) {
      borderColor = AppTheme.yellow;
      backgroundColor = isDark ? const Color(0xFF4A3B00) : const Color(0xFFFFF5D5);
    }

    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: borderColor,
              width: selected || isCorrect != null ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppTheme.yellow.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  String.fromCharCode(65 + index),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              if (isCorrect == true)
                const Icon(Icons.check_circle, color: AppTheme.green)
              else if (isCorrect == false)
                const Icon(Icons.cancel, color: AppTheme.red)
              else if (selected)
                Icon(
                  Icons.check_circle,
                  color: isDark ? AppTheme.yellow : AppTheme.dark,
                ),
            ],
          ),
        ),
      ),
    );
  }
}