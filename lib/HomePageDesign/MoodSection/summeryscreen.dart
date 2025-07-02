import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_ai/HomePageDesign/MoodSection/historyscreen.dart';

class SummaryScreen extends StatefulWidget {
  final String selectedMood;
  final Map<String, List<String>> selectedActivities;


  const SummaryScreen({
    super.key,
    required this.selectedMood,
    required this.selectedActivities,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveEntryToHive();
  }

  void saveEntryToHive()async{
    final box=Hive.box('mood_history');
    final today=DateTime.now().toIso8601String();


    //saving the entry
    await box.put(today, 
    {
      'date':today,
       'mood':widget.selectedMood,
       'activities':widget.selectedActivities,
    }
    );
    print("Saved to Hive with date succefully");
  }

  String _formatDate() {
    final now = DateTime.now();
    return DateFormat('EEEE, MMMM d, yyyy').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFD),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Daily Mood Summary',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
         IconButton(
  icon: Icon(Icons.history),
  onPressed: () {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const HistoryScreen()));
  },
)

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                _formatDate(),
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey.shade700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Mood: ${widget.selectedMood[0].toUpperCase()}${widget.selectedMood.substring(1)}',
                      style: GoogleFonts.dancingScript(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Lottie.asset(
                      'assets/animation/${widget.selectedMood.toLowerCase()}.json',
                      height: 180,
                      repeat: true,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Divider(
                color: Colors.blueGrey.shade200,
                thickness: 1,
              ),
              const SizedBox(height: 20),
              ...widget.selectedActivities.entries.map((entry) {
                final category = entry.key;
                final items = entry.value;
                if (items.isEmpty) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        category,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.blueGrey.shade100),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            for (int i = 0; i < items.length; i += 2)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  _buildChip(items[i]),
                                  const SizedBox(width: 12),
                                  if (i + 1 < items.length)
                                    _buildChip(items[i + 1]),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Chip(
        label: Text(
          item,
          style: GoogleFonts.dancingScript(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
