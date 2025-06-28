// Flutter Mood Assessment Quiz with Emoji Answers and Emotion Scoring
// ------------------------------------------------------------
// This code builds a quiz where each question has emojis representing emotional responses.
// It calculates emotion scores and shows results as emojis and progress bars.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/mooddetection/resultpage.dart';

void main() => runApp(const MoodQuizApp());

class MoodQuizApp extends StatelessWidget {
  const MoodQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Quiz',
      home: const MoodQuizPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MoodQuestion {
  final String question;
  final List<String> emojiOptions;
  final Map<int, Map<String, int>> emotionScoring;

  MoodQuestion({
    required this.question,
    required this.emojiOptions,
    required this.emotionScoring,
  });
}

class MoodQuizPage extends StatefulWidget {
  const MoodQuizPage({super.key});

  @override
  State<MoodQuizPage> createState() => _MoodQuizPageState();
}

class _MoodQuizPageState extends State<MoodQuizPage> {
  int _currentQuestionIndex = 0;
  final Map<String, int> _emotionScores = {
    'joy': 0,
    'sadness': 0,
    'fear': 0,
    'anger': 0,
    'love': 0,
  };

  final List<int> _selectedIndexes = []; // Tracks user selections

  final List<MoodQuestion> _questions = [
    MoodQuestion(
      question: "How are you feeling today?",
      emojiOptions: ["😄", "🙂", "😐", "😔", "😢"],
      emotionScoring: {
        0: {'joy': 5},
        1: {'joy': 4},
        2: {},
        3: {'sadness': 4},
        4: {'sadness': 5},
      },
    ),
    MoodQuestion(
      question: "How frustrated do you feel?",
      emojiOptions: ["😠", "😤", "😐", "🙂", "😌"],
      emotionScoring: {
        0: {'anger': 5},
        1: {'anger': 4},
        2: {},
        3: {},
        4: {},
      },
    ),
    MoodQuestion(
      question: "Do you feel anxious or tense?",
      emojiOptions: ["😱", "😰", "😐", "🙂", "😌"],
      emotionScoring: {
        0: {'fear': 5},
        1: {'fear': 4},
        2: {},
        3: {},
        4: {},
      },
    ),
    MoodQuestion(
      question: "Do you feel emotionally close to someone?",
      emojiOptions: ["❤️", "😊", "😐", "😕", "💔"],
      emotionScoring: {
        0: {'love': 5},
        1: {'love': 3},
        2: {},
        3: {'sadness': 3},
        4: {'sadness': 5},
      },
    ),
    MoodQuestion(
      question: "Do you feel hopeful about the future?",
      emojiOptions: ["🌈", "🙂", "😐", "😟", "😞"],
      emotionScoring: {
        0: {'joy': 5},
        1: {'joy': 3},
        2: {},
        3: {'sadness': 3},
        4: {'sadness': 5},
      },
    ),
  ];

  void _selectAnswer(int index) {
    final current = _questions[_currentQuestionIndex];
    final scoring = current.emotionScoring[index];

    // Update emotion scores
    scoring?.forEach((emotion, value) {
      _emotionScores[emotion] = (_emotionScores[emotion] ?? 0) + value;
    });

    setState(() {
      _selectedIndexes.add(index);
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultPage(emotionScores: _emotionScores),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex];

    return Scaffold(
      
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Center(child: const Text("Mood Quiz")),
        
      // ),
      body: Stack(
 children: [
  SizedBox.expand(
    child: Image.network('https://i.imgur.com/1Tvwwyp.jpeg',
    fit: BoxFit.cover,
    
    ),
    
  ),
  Positioned.fill(
    child:BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        color: Colors.black.withOpacity(0.3),
      ),
      )
   ),
  
    // Foreground quiz content
    SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),

      
      
       child: 
        Column(
          children: [

             Container(
              child: Center(
                child: Text("Check Your Mood Tday",
                style: GoogleFonts.playfairDisplay(
                  color: Colors.white, 
                  fontSize: 34,
                  fontWeight: FontWeight.bold
                  ),
                ),
              ),
             ),

            Center(  
              child: Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.only(top: 170),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress
                    Text(
              "Question ${_currentQuestionIndex + 1} of ${_questions.length}",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 10),
              
                    // Question Text
                    Text(
              _questions[_currentQuestionIndex].question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
              
                    // Instruction
                    Text(
              "Tap the emoji that best matches how you feel",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 30),
              
                    // Emoji options
                    Wrap(
              spacing: 16,
              runSpacing: 16,
              children: List.generate(
                question.emojiOptions.length,
                (index) => GestureDetector(
                  onTap: () => _selectAnswer(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.teal.shade50,
                      border: Border.all(
                        color: Colors.teal.shade200,
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      question.emojiOptions[index],
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )

    ),
  ],
      )
  
); 
  }
}

//         child: 
//         Container(
//   padding: const EdgeInsets.all(24),
//   margin: const EdgeInsets.all(16),
//   decoration: BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(24),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.2),
//         blurRadius: 12,
//         offset: const Offset(0, 6),
//       ),
//     ],
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       // Progress
//       Text(
//         "Question ${_currentQuestionIndex + 1} of ${_questions.length}",
//         style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//       ),
//       const SizedBox(height: 10),

//       // Question Text
//       Text(
//         _questions[_currentQuestionIndex].question,
//         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//       const SizedBox(height: 10),

//       // Instruction
//       Text(
//         "Tap the emoji that best matches how you feel",
//         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//       ),
//       const SizedBox(height: 30),

//       // Emoji options
//       Wrap(
//         spacing: 16,
//         runSpacing: 16,
//         children: List.generate(
//           question.emojiOptions.length,
//           (index) => GestureDetector(
//             onTap: () => _selectAnswer(index),
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.teal.shade50,
//                 border: Border.all(
//                   color: Colors.teal.shade200,
//                   width: 1.5,
//                 ),
//               ),
//               child: Text(
//                 question.emojiOptions[index],
//                 style: const TextStyle(fontSize: 32),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// )

//       ),
//       )
//     );
//   }
// }
