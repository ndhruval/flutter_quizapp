// widgets/questions_summary.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsSummary extends StatelessWidget {
  const QuestionsSummary(this.summaryData, {super.key});

  final List<Map<String, Object>> summaryData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true, // Allows ListView to occupy minimum space
      physics: const NeverScrollableScrollPhysics(), // Disables internal scrolling
      itemCount: summaryData.length,
      itemBuilder: (context, index) {
        final data = summaryData[index];
        final questionIndex = data['question_index'] as int;
        final question = data['question'] as String;
        final correctAnswer = data['correct_answer'] as String;
        final userAnswer = data['user_answer'] as String;

        final isCorrect = userAnswer == correctAnswer;

        return Card(
          color: isCorrect ? Colors.green.shade50 : Colors.red.shade50,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Text
                Text(
                  'Q${questionIndex + 1}: $question',
                  style: GoogleFonts.merriweather(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                // User's Answer
                Row(
                  children: [
                    Icon(
                      isCorrect ? Icons.check_circle : Icons.cancel,
                      color: isCorrect ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        userAnswer,
                        style: GoogleFonts.merriweather(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Correct Answer (only if incorrect)
                if (!isCorrect)
                  Row(
                    children: [
                      const Icon(
                        Icons.info,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Correct Answer: $correctAnswer',
                          style: GoogleFonts.merriweather(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
