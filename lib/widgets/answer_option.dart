
import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final String text;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const AnswerOption({
    super.key,
    required this.text,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: selected
          ? (isDark ? const Color(0xFF4A3B00) : const Color(0xFFFFE082))
          : theme.cardColor,
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
              color: selected
                  ? const Color(0xFFFFB800)
                  : theme.dividerColor,
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFFB800)
                      : theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: selected
                        ? const Color(0xFF242424)
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (selected)
                Icon(
                  Icons.check_circle,
                  color: isDark ? const Color(0xFFFFB800) : const Color(0xFF8A6500),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
