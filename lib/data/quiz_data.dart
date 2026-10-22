
import '../models/question.dart';

const List<Question> quizQuestions = [
  Question(
    category: 'Pemrograman',
    question: 'Apa kepanjangan dari HTML?',
    options: [
      'HyperText Markup Language',
      'HighText Machine Language',
      'HyperTool Multi Language',
      'HomeText Markup Language',
    ],
    correctAnswerIndex: 0,
    explanation:
    'HTML adalah bahasa markup yang digunakan untuk menyusun struktur halaman web.',
  ),
  Question(
    category: 'Pemrograman',
    question: 'Manakah bahasa yang digunakan Flutter?',
    options: ['Java', 'Dart', 'PHP', 'Ruby'],
    correctAnswerIndex: 1,
    explanation:
    'Flutter menggunakan Dart untuk membangun antarmuka dan logika aplikasi.',
  ),
  Question(
    category: 'Pemrograman',
    question: 'Apa fungsi utama sebuah variabel?',
    options: [
      'Menghapus program',
      'Mempercepat internet',
      'Menyimpan nilai atau data',
      'Mengganti sistem operasi',
    ],
    correctAnswerIndex: 2,
    explanation:
    'Variabel merupakan tempat untuk menyimpan nilai yang dapat digunakan program.',
  ),
  Question(
    category: 'Pemrograman',
    question: 'Widget Flutter yang dapat menyimpan state adalah?',
    options: [
      'Text',
      'Icon',
      'StatelessWidget',
      'StatefulWidget',
    ],
    correctAnswerIndex: 3,
    explanation:
    'StatefulWidget digunakan saat tampilan perlu berubah mengikuti state.',
  ),
  Question(
    category: 'Teknologi',
    question: 'Apa kepanjangan CPU?',
    options: [
      'Central Processing Unit',
      'Computer Personal Utility',
      'Central Program User',
      'Control Power Unit',
    ],
    correctAnswerIndex: 0,
    explanation:
    'CPU memproses instruksi dan menjalankan operasi utama komputer.',
  ),
  Question(
    category: 'Teknologi',
    question: 'Manakah yang termasuk perangkat input?',
    options: ['Monitor', 'Keyboard', 'Speaker', 'Proyektor'],
    correctAnswerIndex: 1,
    explanation:
    'Keyboard digunakan untuk memasukkan teks dan perintah ke komputer.',
  ),
  Question(
    category: 'Teknologi',
    question: 'Apa fungsi RAM?',
    options: [
      'Mencetak dokumen',
      'Menyimpan data selamanya',
      'Menyimpan data sementara saat program berjalan',
      'Menghubungkan kabel listrik',
    ],
    correctAnswerIndex: 2,
    explanation:
    'RAM menyimpan data sementara yang sedang digunakan oleh sistem.',
  ),
  Question(
    category: 'Pengetahuan Umum',
    question: 'Apa ibu kota Indonesia?',
    options: ['Bandung', 'Medan', 'Surabaya', 'Jakarta'],
    correctAnswerIndex: 3,
    explanation:
    'Jakarta adalah jawaban yang digunakan dalam kumpulan soal dasar ini.',
  ),
  Question(
    category: 'Pengetahuan Umum',
    question: 'Planet yang dikenal sebagai Planet Merah adalah?',
    options: ['Mars', 'Venus', 'Jupiter', 'Merkurius'],
    correctAnswerIndex: 0,
    explanation:
    'Mars terlihat kemerahan karena mineral besi teroksidasi di permukaannya.',
  ),
  Question(
    category: 'Pengetahuan Umum',
    question: 'Berapa hasil dari 12 x 5?',
    options: ['50', '60', '55', '65'],
    correctAnswerIndex: 1,
    explanation: '12 dikalikan 5 sama dengan 60.',
  ),
];

const List<String> quizCategories = [
  'Semua Kategori',
  'Pemrograman',
  'Teknologi',
  'Pengetahuan Umum',
];
