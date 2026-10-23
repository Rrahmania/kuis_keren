import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();
    final history = quizProvider.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Kuis'),
        actions: [
          if (history.isNotEmpty)
            IconButton(
              tooltip: 'Hapus riwayat',
              icon: const Icon(Icons.delete_outline),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Hapus Riwayat?'),
                    content: const Text(
                      'Apakah kamu yakin ingin menghapus seluruh riwayat kuis?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        child: const Text('Batal'),
                      ),
                      FilledButton(
                        onPressed: () {
                          quizProvider.clearHistory();
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Hapus'),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.history, size: 64),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada riwayat kuis.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 6),
                    Text('Selesaikan kuis untuk melihat hasilnya di sini.'),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: history.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = history[index];
                final rawDate = item['date'];
                final DateTime date = rawDate is DateTime
                    ? rawDate
                    : (rawDate is String
                        ? (DateTime.tryParse(rawDate) ?? DateTime.now())
                        : DateTime.now());

                final scoreNum = item['score'] as num? ?? 0;

                return Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      child: Icon(Icons.emoji_events_outlined),
                    ),
                    title: Text('${item['name']}'),
                    subtitle: Text(
                      '${item['category']} • '
                      '${item['correct']}/${item['total']} benar\n'
                      '${date.day}/${date.month}/${date.year} '
                      '${date.hour.toString().padLeft(2, '0')}:'
                      '${date.minute.toString().padLeft(2, '0')}',
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      scoreNum.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}