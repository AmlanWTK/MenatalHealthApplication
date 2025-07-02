import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/Models/custom_icon.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/summeryscreen.dart';
  // Import summary screen

class ActivityEntryScreen extends StatefulWidget {
  final List<String> selectedCategories;
  final String selectedMood;  // <-- Receive mood from previous screen

  const ActivityEntryScreen({
    super.key,
    required this.selectedCategories,
    required this.selectedMood,
  });

  @override
  State<ActivityEntryScreen> createState() => _ActivityEntryScreenState();
}

class _ActivityEntryScreenState extends State<ActivityEntryScreen> {
  List<CustomIcon> allIcons = [];
  final Map<String, bool> expanded = {};
  final Map<String, List<String>> predefinedItems = {
    'Emotions': [
      'happy', 'excited', 'alone', 'relaxed',
      'tired', 'confused', 'bored', 'anxious', 'angry',
      'calm', 'sad', 'tired',
    ],
    'Sleep': ['good sleep', 'medium sleep', 'bad sleep', 'sleep early'],
    'Hobbies': ['music', 'read', 'pets', 'relax', 'coding', 'travel'],
    'Health': ['exercise', 'hydrated', 'healthy-food', 'meditation'],
  };

  // Track selected items by category
  final Map<String, Set<String>> selectedItems = {};

  @override
  void initState() {
    super.initState();
    for (var category in widget.selectedCategories) {
      expanded[category] = true;
      selectedItems[category] = {}; // initialize empty selection sets
    }
    loadIcons();
  }

  Future<void> loadIcons() async {
    final jsonString = await rootBundle.loadString('assets/data/icon_library.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      allIcons = jsonList.map((e) => CustomIcon.fromJson(e)).toList();
    });
  }

  String getIconPath(String label) {
    final match = allIcons.firstWhere(
      (icon) =>
          icon.name.toLowerCase() == label.toLowerCase() ||
          icon.tags.any((tag) => tag.toLowerCase().contains(label.toLowerCase())),
      orElse: () => CustomIcon(name: '', path: 'assets/icons/default.svg', category: '', tags: []),
    );
    return match.path;
  }

  void toggleItemSelection(String category, String item) {
    setState(() {
      final selectedSet = selectedItems[category]!;
      if (selectedSet.contains(item)) {
        selectedSet.remove(item);
      } else {
        selectedSet.add(item);
      }
    });
  }

  void goToSummary() {
    // Convert Set<String> to List<String> for all categories
    final Map<String, List<String>> selections = {};
    selectedItems.forEach((key, value) {
      selections[key] = value.toList();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryScreen(
          selectedMood: widget.selectedMood,
          selectedActivities: selections,
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: widget.selectedCategories.map((category) {
                  final items = predefinedItems[category] ?? [];
                  final isExpanded = expanded[category] ?? false;

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey, width: 5),
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(colors: [
                        Color(0xFFF0F7FD),
                        Color(0xFFE6F4FF),
                        Color(0xFFE1F0FA),
                      ]),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with expand/collapse
                        Row(
                          children: [
                            Text(
                              category,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 20,
                                color: const Color(0xFF7B4B42),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.add, color: Colors.white),
                              onPressed: () {}, // TODO: Add custom item
                            ),
                            IconButton(
                              icon: Icon(
                                isExpanded ? Icons.expand_less : Icons.expand_more,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  expanded[category] = !isExpanded;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Grid of selectable icons/items
                        if (isExpanded)
                          Wrap(
                            spacing: 20,
                            runSpacing: 20,
                            children: items.map((item) {
                              final isSelected = selectedItems[category]?.contains(item) ?? false;
                              return GestureDetector(
                                onTap: () => toggleItemSelection(category, item),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor:
                                          isSelected ? Colors.blueGrey : Colors.black,
                                      child: SvgPicture.asset(
                                        getIconPath(item),
                                        width: 28,
                                        height: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item,
                                      style: GoogleFonts.dancingScript(
                                        color: const Color(0xFF7B4B42),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: goToSummary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(
                  "Continue",
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 25,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
