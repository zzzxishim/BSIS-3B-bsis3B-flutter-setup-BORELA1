import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peñafrancia Food Park',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool showStart = true;
  bool showQuiz = false;
  bool showEnd = false;

  int score = 0;
  bool answerSelected = false;

  final Map<String, dynamic> question = {
    "question":
        "Which mobile app feature would help Peñafrancia Food Park in Naga City manage peak-hour customers better?",
    "answers": [
      {"text": "Digital order & pickup queue system", "correct": true},
      {"text": "Built-in music streaming", "correct": false},
      {"text": "Photo filter editor", "correct": false},
      {"text": "Mobile games section", "correct": false},
    ]
  };

  void startQuiz() {
    setState(() {
      showStart = false;
      showQuiz = true;
      showEnd = false;
      score = 0;
      answerSelected = false;
    });
  }

  void selectAnswer(bool isCorrect) {
    if (answerSelected) return;

    setState(() {
      answerSelected = true;
      if (isCorrect) score++;
    });
  }

  void nextScreen() {
    setState(() {
      showQuiz = false;
      showEnd = true;
    });
  }

  void restartQuiz() {
    setState(() {
      showStart = true;
      showQuiz = false;
      showEnd = false;
      score = 0;
      answerSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peñafrancia Food Park"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: showStart
              ? buildStartView()
              : showQuiz
                  ? buildQuizView()
                  : buildEndView(),
        ),
      ),
    );
  }

  Widget buildStartView() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.restaurant, size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              "Peñafrancia Food Park",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Business App Feature Quiz",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: startQuiz,
              child: const Text("Start Quiz"),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildQuizView() {
    return Column(
      children: [
        Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              question["question"],
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...question["answers"].map<Widget>((answer) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: answerSelected
                    ? null
                    : () => selectAnswer(answer["correct"]),
                child: Text(answer["text"]),
              ),
            ),
          );
        }).toList(),
        const SizedBox(height: 20),
        if (answerSelected)
          ElevatedButton.icon(
            onPressed: nextScreen,
            icon: const Icon(Icons.arrow_forward),
            label: const Text("Next"),
          ),
      ],
    );
  }

  Widget buildEndView() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events,
                size: 60, color: Colors.orange),
            const SizedBox(height: 16),
            const Text(
              "Quiz Completed!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Your Score: $score / 1",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: restartQuiz,
              child: const Text("Restart"),
            ),
          ],
        ),
      ),
    );
  }
}
