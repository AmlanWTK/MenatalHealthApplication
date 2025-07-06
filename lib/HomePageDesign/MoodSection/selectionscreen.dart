// selectionscreen.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mental_health_ai/HomePageDesign/MoodSection/activityscreen.dart';

class SelectionScreen extends StatefulWidget {
  final String selectedMood;  // NEW: receive selected mood from previous screen

  const SelectionScreen({super.key, required this.selectedMood}); // updated constructor

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final List<String> categories = ['Emotions', 'Sleep', 'Health', 'Hobbies','School','Chores','Weather'];
  final Set<String> selected = {'Emotions', 'Sleep'};

  void toggleSelection(String category) {
    setState(() {
      if (selected.contains(category)) {
        selected.remove(category);
      } else {
        selected.add(category);
      }
    });
  }

  void goToNextPage() {
    // Pass selectedMood along with categories to next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ActivityEntryScreen(
          selectedCategories: selected.toList(),
          selectedMood: widget.selectedMood,  // NEW: pass mood here
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFD),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey, width: 5),
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF0F7FD),
                  Color(0xFFE6F4FF),
                  Color(0xFFE1F0FA),
                ],
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.3),
              //     blurRadius: 10,
              //     offset: const Offset(0, 6),
              //     spreadRadius: 10,
              //   ),
              // ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Amlan, what would you like to keep an eye on?",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 38,
                          color: const Color(0xFF7B4B42),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '''Add depth to your diary entries by selecting activities you engage in.
Observe how they impact your emotions over time. Here are a few suggestions to start with:
Track daily habits that influence your mental well-being.
Notice patterns between what you do and how you feel.
This will help you build awareness and take meaningful actions.''',
                        style: GoogleFonts.dancingScript(
                          fontSize: 28,
                          color: const Color(0xFF7B4B42),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
  flex: 5,
  child: Column(
    children: [
      Expanded(
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
          child: SingleChildScrollView(
           
            child: Column(
              children: [
                ...categories.map((cat) {
                  final isSelected = selected.contains(cat);
                  return GestureDetector(
                    onTap: () => toggleSelection(cat),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        // boxShadow: const [
                        //   BoxShadow(
                        //     color: Colors.black26,
                        //     blurRadius: 6,
                        //     offset: Offset(0, 4),
                        //   ),
                        // ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: isSelected ? Colors.blueGrey : Colors.grey,
                          ),
                          const SizedBox(width: 16),
                          Text(
                            cat,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF333333),
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            _getCategoryIcon(cat),
                            size: 30,
                            color: const Color(0xFF333333),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 20), // Add spacing before button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: goToNextPage,
                    icon: const Icon(Icons.arrow_forward),
                    label: Text(
                      "Next",
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 25, color: Colors.grey.shade300),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  ),
),







              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String cat) {
    switch (cat) {
      case 'Emotions':
        return Icons.emoji_emotions;
      case 'Sleep':
        return Icons.bedtime;
      case 'Health':
        return Icons.directions_run;
      case 'Hobbies':
        return Icons.menu_book;
      default:
        return Icons.circle;
    }
  }
}
