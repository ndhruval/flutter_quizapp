// widgets/results_screen.dart
import 'package:adv_basics/data/questions.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart, // Added onRestart callback
  });

  final List<String> chosenAnswers;
  final void Function() onRestart; // Define the callback

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i],
      });
    }

    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;

    // Calculate percentage score
    final scorePercentage = (numCorrectQuestions / numTotalQuestions) * 100;

    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView( // Enables scrolling
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Adjust size based on content
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Quiz Results',
                style: GoogleFonts.merriweather(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 72, 31, 225),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'You scored $numCorrectQuestions out of $numTotalQuestions!',
                style: GoogleFonts.merriweather(
                  fontSize: 20,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '${scorePercentage.toStringAsFixed(1)}%',
                style: GoogleFonts.merriweather(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: scorePercentage >= 50
                      ? Colors.green
                      : Colors.red, // Color based on score
                ),
              ),
              const SizedBox(height: 30),
              QuestionsSummary(summaryData), // Display summary
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: onRestart, // Invoke the callback
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  backgroundColor: const Color.fromARGB(255, 72, 31, 225),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.restart_alt),
                label: const Text(
                  'Restart Quiz!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
