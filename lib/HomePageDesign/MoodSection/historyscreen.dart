import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:mental_health_ai/Navbar/customnavbar.dart';



class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final scrolled = _scrollController.offset > 20;
      if (scrolled != _isScrolled) {
        setState(() => _isScrolled = scrolled);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('mood_history');

    final entries = box.toMap().entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key));

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFD),
      body: Column(
        children: [
          // ✅ Custom navbar at top
          CustomNavBar(isScrolled: _isScrolled),

          // ✅ Page heading just below navbar
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Mood History',
              style: GoogleFonts.playfairDisplay(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey.shade800,
              ),
            ),
          ),

          // ✅ Scrollable list of mood history
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final date = entries[index].key;
                final data = Map<String, dynamic>.from(entries[index].value);
                final mood = data['mood'] ?? '';
                final activities = Map<String, dynamic>.from(data['activities'] ?? {});

                return Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.blueGrey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formatDate(date),
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Lottie.asset(
                            'assets/animation/${mood.toLowerCase()}.json',
                            height: 60,
                            repeat: true,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            mood[0].toUpperCase() + mood.substring(1),
                            style: GoogleFonts.dancingScript(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ...activities.entries.map((entry) {
                        final items = List<String>.from(entry.value);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey.shade600,
                              ),
                            ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: items
                                  .map((item) => Chip(
                                        label: Text(item),
                                        backgroundColor: Colors.blueGrey.shade100,
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 12),
                          ],
                        );
                      })
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return isoDate;
    return '${date.day}/${date.month}/${date.year}';
  }
}
