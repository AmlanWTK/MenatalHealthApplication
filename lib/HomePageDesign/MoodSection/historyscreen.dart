import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('mood_history');

    // 📦 Get all saved entries from Hive
    final entries = box.toMap().entries.toList()
      ..sort((a, b) => b.key.compareTo(a.key)); // Sort latest first

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFD),
      appBar: AppBar(
        title: Text(
          'Mood History',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: ListView.builder(
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
                        children: items.map((item) => Chip(
                          label: Text(item),
                          backgroundColor: Colors.blueGrey.shade100,
                        )).toList(),
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
    );
  }

  // 🗓 Format the ISO 8601 date string
  String formatDate(String isoDate) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return isoDate;
    return '${date.day}/${date.month}/${date.year}';
  }
}
