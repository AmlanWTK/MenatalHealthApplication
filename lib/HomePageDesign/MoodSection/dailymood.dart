import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/selectionscreen.dart';

class DailyMood extends StatefulWidget {
  const DailyMood({super.key});

  @override
  State<DailyMood> createState() => _DailyMoodState();
}

class _DailyMoodState extends State<DailyMood> {
  String selectedMood = 'happy';

  final List<String> moodRow1 = ['happy', 'lovely', 'excited', 'neutral'];
  final List<String> moodRow2 = ['angry', 'sad', 'awful'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: double.infinity,
              height: 600,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              decoration: BoxDecoration(
                gradient: _getMoodGradient(selectedMood),
                border: Border.all(color: Colors.blueGrey, width: 5),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    "How is your day Today?",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 38,
                      color: const Color(0xFF7B4B42),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: Lottie.asset(
                      'assets/animation/${selectedMood.toLowerCase()}.json',
                      key: ValueKey<String>(selectedMood),
                      height: 220,
                      repeat: true,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        moodRow1.map((mood) => _buildMoodButton(mood)).toList(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        moodRow2.map((mood) => _buildMoodButton(mood)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  LinearGradient _getMoodGradient(String mood) {
    switch (mood) {
      case 'happy':
        return LinearGradient(colors: [Colors.yellow.shade100, Colors.orange.shade100]);
      case 'sad':
        return LinearGradient(colors: [Colors.blue.shade200, Colors.blueGrey.shade100]);
      case 'angry':
        return LinearGradient(colors: [Colors.red.shade300, Colors.deepOrange.shade100]);
      case 'excited':
        return LinearGradient(colors: [Colors.orangeAccent.shade100, Colors.pinkAccent.shade100]);
      case 'bad':
        return LinearGradient(colors: [Colors.grey.shade400, Colors.grey.shade200]);
      case 'lovely':
        return LinearGradient(colors: [Colors.pink.shade100, Colors.purple.shade100]);
      case 'neutral':
        return LinearGradient(colors: [Colors.teal.shade100, Colors.cyan.shade100]);
      case 'awful':
        return LinearGradient(colors: [Colors.blue.shade200, Colors.blueGrey.shade100]);
      default:
        return LinearGradient(colors: [Colors.white, Colors.grey.shade100]);
    }
  }

  Widget _buildMoodButton(String mood) {
    final isSelected = selectedMood == mood;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedMood = mood;
          });

          // Wait 2.5 seconds to show the mood animation before navigation
          Future.delayed(const Duration(milliseconds: 2500), () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectionScreen(
                  selectedMood: selectedMood, // Pass selected mood here
                ),
              ),
            );
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blueGrey : Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(0, 6),
              )
            ],
          ),
          child: Text(
            mood[0].toUpperCase() + mood.substring(1),
            style: GoogleFonts.dancingScript(
              color: isSelected ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
