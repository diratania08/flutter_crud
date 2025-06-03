import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/question_data.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quiz = Provider.of<QuizProvider>(context);
    final questions = jawabanMapping.keys.toList();

    if (quiz.currentIndex >= questions.length) {
      quiz.simpanSkor();

      return Scaffold(
        appBar: AppBar(title: Text("Hasil")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Skor Akhir Anda : ${quiz.totalScore}",
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(
                      context, quiz.totalScore); // kirim skor ke HomeScreen
                },
                child: Text("Selesai"),
              ),
            ],
          ),
        ),
      );
    }

    final currentQuestion = questions[quiz.currentIndex];
    final answers = jawabanMapping[currentQuestion]!;

    return Scaffold(
      appBar: AppBar(title: Text('Pertanyaan ${quiz.currentIndex + 1}')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentQuestion, style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ...answers.entries.map((entry) => ElevatedButton(
                  onPressed: () => quiz.answer(entry.value),
                  child: Text(entry.key),
                )),
          ],
        ),
      ),
    );
  }
}
