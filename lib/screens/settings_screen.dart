import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quizProvider = context.watch<QuizProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Icon(Icons.lightbulb_rounded, size: 72),
          const SizedBox(height: 16),
          const Text(
            'Kuis Pintar',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Aplikasi kuis pilihan ganda untuk menguji pengetahuan '
            'pengguna melalui berbagai kategori soal.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          SwitchListTile(
            secondary: Icon(
              quizProvider.isDarkMode
                  ? Icons.dark_mode_rounded
                  : Icons.light_mode_rounded,
            ),
            title: const Text('Mode Gelap'),
            subtitle: Text(
              quizProvider.isDarkMode ? 'Mode Gelap Aktif' : 'Mode Terang Aktif',
            ),
            value: quizProvider.isDarkMode,
            onChanged: (value) {
              quizProvider.toggleTheme(value);
            },
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.palette_outlined),
            title: Text('Tema aplikasi'),
            subtitle: Text('Mode terang & gelap dengan aksen kuning'),
          ),
          const ListTile(
            leading: Icon(Icons.storage_outlined),
            title: Text('Penyimpanan'),
            subtitle: Text('Data soal lokal, tanpa database server'),
          ),
          const ListTile(
            leading: Icon(Icons.code),
            title: Text('Teknologi'),
            subtitle: Text('Flutter, Dart, dan Provider'),
          ),
        ],
      ),
    );
  }
}