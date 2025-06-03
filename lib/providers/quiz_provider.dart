import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  int currentIndex = 0;
  int totalScore = 0;

  // Tambahan: simpan semua skor user
  List<int> skorSemuaUser = [];

  void answer(int score) {
    totalScore += score;
    currentIndex++;
    notifyListeners();
  }

  // Dipanggil setelah quiz selesai
  void simpanSkor() {
    skorSemuaUser.add(totalScore);
    notifyListeners();
  }

  void reset() {
    currentIndex = 0;
    totalScore = 0;
    notifyListeners();
  }
}
