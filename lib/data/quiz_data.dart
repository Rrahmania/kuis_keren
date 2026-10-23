import '../models/question.dart';

const List<Question> quizQuestions = [
  Question(
    id: 'q1',
    category: 'Teknologi',
    question: 'Apa kepanjangan dari CPU?',
    options: [
      'Central Processing Unit',
      'Computer Personal Unit',
      'Central Program Utility',
      'Control Processing User',
    ],
    correctIndex: 0,
    explanation:
    'CPU adalah Central Processing Unit, yaitu komponen yang menjalankan instruksi dan memproses data.',
  ),
  Question(
    id: 'q2',
    category: 'Teknologi',
    question: 'Bahasa pemrograman yang digunakan Flutter adalah?',
    options: [
      'Java',
      'Dart',
      'Kotlin',
      'Swift',
    ],
    correctIndex: 1,
    explanation:
    'Flutter menggunakan Dart sebagai bahasa pemrograman utamanya.',
  ),
  Question(
    id: 'q3',
    category: 'Pengetahuan Umum',
    question: 'Apa ibu kota Indonesia?',
    options: [
      'Bandung',
      'Surabaya',
      'Jakarta',
      'Medan',
    ],
    correctIndex: 2,
    explanation:
    'Jakarta merupakan jawaban yang digunakan pada kumpulan soal latihan ini.',
  ),
  Question(
    id: 'q4',
    category: 'Sains',
    question: 'Planet yang dikenal sebagai Planet Merah adalah?',
    options: [
      'Venus',
      'Jupiter',
      'Merkurius',
      'Mars',
    ],
    correctIndex: 3,
    explanation:
    'Mars dikenal sebagai Planet Merah karena warna permukaannya yang kemerahan.',
  ),
  Question(
    id: 'q5',
    category: 'Pengetahuan Umum',
    question: 'Berapakah hasil dari 12 × 8?',
    options: [
      '86',
      '96',
      '108',
      '92',
    ],
    correctIndex: 1,
    explanation: '12 dikali 8 sama dengan 96.',
  ),
];